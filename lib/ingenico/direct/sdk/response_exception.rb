module Ingenico::Direct::SDK

  # Exception used internally in the SDK to indicate an error response was received from the Ingenico ePayments platform.
  #
  # @attr_reader [Integer] status_code HTTP status code that was returned by the Ingenico ePayments platform
  # @attr_reader [String] body         HTTP message body that was returned by the Ingenico ePayments platform
  # @attr_reader [Array<Ingenico:Direct:SDK:ResponseHeader>] headers HTTP headers used in the response from the Ingenico ePayments platform
  class ResponseException < RuntimeError

    def initialize(status_code, headers, body)
      super('the Ingenico ePayments platform returned an error response')
      @status_code = status_code
      @headers = if headers.nil? || headers.empty?
                   {}
                 else
                   headers.inject({}) do |hash, header|
                     hash[header.name.downcase.to_sym] = header.dup.freeze
                     hash
                   end
                 end.freeze
      @body = body
    end

    attr_reader :status_code
    attr_reader :body
    attr_reader :headers

    # Returns the {Ingenico::Direct::SDK::ResponseHeader} that corresponds to the given _header_name_
    # used in the HTTP response from the Ingenico ePayments platform, or *nil* if the header was not present in the response.
    def get_header(header_name)
      ResponseHeader.get_header(@headers, header_name)
    end

    # Returns the header value received that corresponds to the header named by _header_name_,
    # or *nil* if _header_name_ was not a header present in the HTTP response.
    def get_header_value(header_name)
      ResponseHeader.get_header_value(@headers, header_name)
    end

    def to_s
      str = super.to_s
      str += "; status_code=#{@status_code}" if @status_code.positive?
      str += "; response_body='#{@body}'" if @body&.length.positive?
      str.to_s
    end
  end
end
