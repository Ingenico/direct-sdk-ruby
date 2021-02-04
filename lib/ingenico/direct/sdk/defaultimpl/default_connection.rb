require 'securerandom'
require 'uri'
require 'httpclient'

# @private :nodoc: this is not our class
module RefineHTTPClient
  refine HTTPClient do
    # (monkey) patch to gain access to the session pool size in HTTPClient
    def session_count
      sess_pool = @session_manager.instance_variable_get(:@sess_pool)
      sess_pool.size
    end
  end
end

module Ingenico::Direct::SDK
  module DefaultImpl
    class DefaultConnection < PooledConnection
      using RefineHTTPClient

      CONTENT_TYPE = 'Content-Type'.freeze
      JSON_CONTENT_TYPE = 'application/json'.freeze

      # @param args [Hash] the parameters to initialize the connection with
      # @option args [Integer] :connect_timeout connection timeout in seconds.
      #              Uses {CommunicatorConfiguration.default_connect_timeout} if not given.
      # @option args [Integer] :socket_timeout socket timeout in seconds.
      #              Uses {CommunicatorConfiguration.default_socket_timeout} if not given.
      # @option args [Integer] :max_connections number of connections kept alive in the thread pool.
      #              Uses {CommunicatorConfiguration.default_max_connections} if not given.
      # @option args [Hash] :proxy_configuration object that stores the proxy to use.
      #              If not given the system default proxy is used;
      #              if there is no system default proxy set either, no proxy is used.
      def initialize(args)
        raise ArgumentError unless args.is_a? Hash

        super()

        # Set timeouts to nil if they are negative
        @connect_timeout = args[:connect_timeout] || CommunicatorConfiguration.default_connect_timeout
        @connect_timeout = nil unless @connect_timeout&.positive?
        @socket_timeout = args[:socket_timeout] || CommunicatorConfiguration.default_socket_timeout
        @socket_timeout = nil unless @socket_timeout&.positive?
        @max_connections = args[:max_connections] || CommunicatorConfiguration.default_max_connections
        @proxy_configuration = args[:proxy_configuration]

        # HTTPClient provides the following features:
        # 1) thread safe, an instance can be used by multiple threads without
        # explicit synchronization
        # 2) use persistent connection if HTTP 1.1 is supported. The connection
        # will be left open until explicitly closed or keep_alive_timeout
        # 3) a built-in connection pool with no limit for max connections
        @http_client = create_http_client
        @http_client.connect_timeout = @connect_timeout
        @http_client.send_timeout = @socket_timeout
        @http_client.receive_timeout = @socket_timeout
      end

      private

      # Create a HTTPClient instance that uses @proxy_configuration or the system proxy if @proxy_configuration is not set
      def create_http_client
        if @proxy_configuration
          httpclient = HTTPClient.new(@proxy_configuration.proxy_uri)
          httpclient.set_proxy_auth(@proxy_configuration.username, @proxy_configuration.password)
          httpclient.force_basic_auth = true if @proxy_configuration.username && @proxy_configuration.password
        else # use system settings
          proxy_string = ENV['https_proxy'] || ENV['http_proxy']
          # proxy string format = 'http://username:password@hostname:port'
          proxy_string =~ %r{https?//(?<username>[^:]):(?<password>[^@])@.*}
          username = Regexp.last_match(1)
          password = Regexp.last_match(2)
          httpclient = HTTPClient.new(proxy_string)
          httpclient.set_proxy_auth(username, password) if username && password
          httpclient.force_basic_auth = true if username && password
        end
        httpclient
      end

      public

      # Closes all connections idle for longer than _idle_time_ seconds.
      # In addition, the keep_alive_timeout is set to _idle_time_
      # so any future connections idle for longer than _idle_time_ seconds will also be closed.
      def close_idle_connections(idle_time) # in sec
        @http_client.keep_alive_timeout = idle_time # set timeout value
        close_expired_connections
      end

      # HTTPClient automatically closes expired connections so _close_expired_connections_ is a no-operation.
      def close_expired_connections
        # By default the keep alive timeout is 15 sec, which is the HTTP 1.1
        # standard. To change the value, use keep_alive_timeout= method
        # do nothing, handled by HTTPClient
      end

      # Frees all networking resources used.
      def close
        @http_client.reset_all
      end

      # Returns the number of open connections
      def session_count
        @http_client.session_count
      end

      # Performs a GET request to the Ingenico ePayments platform
      # @see request
      def get(uri, request_headers)
        request('get', uri, request_headers) do |response_status_code, response_headers, response_body|
          yield response_status_code, response_headers, response_body
        end
      end

      # Performs a DELETE request to the Ingenico ePayments platform
      # @see request
      def delete(uri, request_headers)
        request('delete', uri, request_headers) do |response_status_code, response_headers, response_body|
          yield response_status_code, response_headers, response_body
        end
      end

      # Performs a POST request to the Ingenico ePayments platform
      # @see request
      def post(uri, request_headers, body)
        request('post', uri, request_headers, body) do |response_status_code, response_headers, response_body|
          yield response_status_code, response_headers, response_body
        end
      end

      # Performs a PUT request to the Ingenico ePayments platform
      # @see request
      def put(uri, request_headers, body)
        request('put', uri, request_headers, body) do |response_status_code, response_headers, response_body|
          yield response_status_code, response_headers, response_body
        end
      end

      # Performs a HTTP request and yields the response as the status code, headers and body.
      # Also ensures the request is logged when sent and its response is logged when received.
      #
      # @param method          [String] 'GET', 'DELETE', 'POST' or 'PUT' depending on the HTTP method being used.
      # @param uri             [URI::HTTP] full URI of the location the request is targeted at, including query parameters.
      # @param request_headers [Array<Ingenico::Direct::SDK::RequestHeader>] list of headers that should be used as HTTP headers in the request.
      # @param body            [String] request body.
      # @yield (Integer, Array<Ingenico::Direct::SDK::ResponseHeader>, IO) The status code, headers and body of the response.
      # @raise [Ingenico::Direct::SDK::CommunicationException] when communication with the Ingenico ePayments platform was not successful.
      def request(method, uri, request_headers, body = nil)
        request_headers = convert_from_headers(request_headers)
        request_id = SecureRandom.uuid
        content_type = request_headers[CONTENT_TYPE]

        info = { headers: request_headers, content_type: content_type }
        info[:body] = body if body

        log_request(request_id, method.upcase, uri, info)

        start_time = Time.now
        begin
          response_headers = nil
          response_status_code = nil
          response_content_type = nil
          response_body = ''
          raw_request(method, uri, request_headers, body) do |status_code, headers, r_content_type, r_body|
            response_headers = headers
            response_status_code = status_code
            response_content_type = r_content_type
            response_body = r_body.read.force_encoding('UTF-8')
            r_body = StringIO.new(response_body)

            yield status_code, headers, r_body
          end

          log_response(request_id, response_status_code, start_time,
                       headers: response_headers, body: response_body,
                       content_type: response_content_type)
        rescue HTTPClient::TimeoutError => e
          log_error(request_id, start_time, e)
          raise Ingenico::Direct::SDK::CommunicationException, e
        rescue HTTPClient::KeepAliveDisconnected, HTTPClient::RetryableResponse => e # retry these?
          log_error(request_id, start_time, e)
          raise Ingenico::Direct::SDK::CommunicationException, e
        rescue StandardError => e
          log_error(request_id, start_time, e)
          raise Ingenico::Direct::SDK::CommunicationException, e
        end
      end

      # logging code

      # Enables logging outgoing requests and incoming responses by registering the _communicator_logger_.
      # Note that only one logger can be registered at a time and calling _enable_logging_
      # a second time will override the old logger instance with the new one.
      #
      # @param communicator_logger [Ingenico::Direct::SDK::Logging::CommunicatorLogger] the communicator logger the requests and responses are logged to
      def enable_logging(communicator_logger)
        raise ArgumentError, 'communicatorLogger is required' unless communicator_logger

        @communicator_logger = communicator_logger
      end

      # Disables logging by unregistering any previous logger that might be registered.
      def disable_logging
        @communicator_logger = nil
      end

      private

      # Converts a {Ingenico::Direct::SDK::RequestHeader} list headers to a hash
      def convert_from_headers(headers)
        headers.each_with_object({}) { |h, hash| hash[h.name] = h.value }
      end

      # Converts a hash to a {Ingenico::Direct::SDK::ResponseHeader} list
      def convert_to_response_headers(headers)
        arr ||= []
        headers.each { |k, v| arr << Ingenico::Direct::SDK::ResponseHeader.new(k, v) }
        arr
      end

      def log_request(request_id, method, uri, args = {})
        return unless @communicator_logger

        headers = args[:headers]
        body = args[:body]
        content_type = args[:content_type]
        log_msg_builder = Ingenico::Direct::SDK::Logging::RequestLogMessageBuilder.new(request_id, method, uri)
        headers.each { |k, v| log_msg_builder.add_headers(k, v) } if headers

        log_msg_builder.set_body(body, content_type)

        begin
          @communicator_logger.log(log_msg_builder.get_message)
        rescue StandardError => e
          @communicator_logger.log("An error occurred trying to log request #{request_id}", e)
        end
      end

      # Creates the log_response stream
      def log_response(request_id, status_code, start_time, args = {})
        return unless @communicator_logger

        duration      = (Time.now - start_time) * 1000 # in milliseconds
        headers       = args[:headers]
        body          = args[:body] if args[:body]
        content_type  = args[:content_type]

        log_msg_builder = Ingenico::Direct::SDK::Logging::ResponseLogMessageBuilder.new(request_id, status_code, duration)
        if headers
          convert_from_headers(headers)
              .each do |key, value|
            log_msg_builder.add_headers(key, value)
          end
        end

        log_msg_builder.set_body(body, content_type)

        begin
          @communicator_logger.log(log_msg_builder.get_message)
        rescue StandardError => e
          @communicator_logger.log("An error occurred trying to log response #{request_id}", e)
        end
      end

      def log_error(request_id, start_time, thrown)
        return unless @communicator_logger

        duration = (Time.now - start_time) * 1000 # in millisecs
        @communicator_logger.log("Error occurred for outgoing request (requestId='#{request_id}', #{duration} ms)", thrown)
      end

      # Makes a request using the specified method
      #
      # Yields a status code, an array of {Ingenico::Direct::SDK::ResponseHeader},
      # the content_type and body
      def raw_request(method, uri, headers, body = nil)
        connection = body ?
                         @http_client.send("#{method}_async", uri, body: body, header: headers) :
                         @http_client.send("#{method}_async", uri, header: headers)

        response = connection.pop
        pipe = response.content
        response_headers = convert_to_response_headers(response.headers)

        begin
          yield response.status_code, response_headers, response.content_type, pipe
        ensure
          pipe.close
        end
      end
    end
  end
end
