require 'yaml'

module Ingenico::Direct::SDK

  # Convenience class that constructs instances of several other classes in the SDK.
  # Provides methods to construct
  # {Ingenico::Direct::SDK::CommunicatorConfiguration}, {Ingenico::Direct::SDK::Communicator} and {Ingenico::Direct::SDK::Client} instances.
  class Factory

    # Creates and returns a {Ingenico::Direct::SDK::CommunicatorConfiguration} based on the configuration in the file located at _configuration_file_name_.
    #
    # @param config_file_name [String] Path to the configuration file to use, should be in YAML format.
    # @param api_key_id       [String] Key id for the GlobalCollect service.
    # @param secret_api_key   [String] Secret key used for authentication to the GlobalCollect service.
    # @return [Ingenico::Direct::SDK::CommunicatorConfiguration] The created communicator configuration
    def self.create_configuration(config_file_name, api_key_id, secret_api_key)
      properties = YAML::load_file(config_file_name)
      CommunicatorConfiguration.new(properties: properties,
                                    api_key_id: api_key_id,
                                    secret_api_key: secret_api_key)
    end

    # Creates and returns an {Ingenico::Direct::SDK::Communicator} that can be used for communication with the GlobalCollect service.
    #
    # @param configuration      [Ingenico::Direct::SDK::CommunicatorConfiguration] contains configuration settings to be used by the client.
    # @param meta_data_provider [Ingenico::Direct::SDK::MetaDataProvider,nil] stores the metadata for the communicating client.
    # @param connection         [Ingenico::Direct::SDK::Connection,nil] connection that can be used to communicate with the Ingenico Direct platform.
    # @param authenticator      [Ingenico::Direct::SDK::Authenticator,nil] authenticator that can authenticate messages sent to the Ingenico Direct platform.
    # @param marshaller         [Ingenico::Direct::SDK::Marshaller,nil] marshaller that marshalls and unmarshalls messages sent to the Ingenico Direct platform.
    # @return [Ingenico::Direct::SDK::Communicator] The created communicator
    def self.create_communicator_from_configuration(configuration, meta_data_provider: nil, connection: nil, authenticator: nil, marshaller: DefaultImpl::DefaultMarshaller.INSTANCE)
      meta_data_provider ||= MetaDataProvider.new(configuration.integrator, shopping_cart_extension: configuration.shopping_cart_extension)
      connection ||= DefaultImpl::DefaultConnection.new({ connect_timeout: configuration.connect_timeout,
                                                          socket_timeout: configuration.socket_timeout,
                                                          max_connections: configuration.max_connections,
                                                          proxy_configuration: configuration.proxy_configuration })
      authenticator ||= DefaultImpl::DefaultAuthenticator.new(configuration.api_key_id,
                                                              configuration.secret_api_key,
                                                              configuration.authorization_type)
      Communicator.new(configuration.api_endpoint, connection, authenticator, meta_data_provider, marshaller)
    end

    # Creates and returns an {Ingenico::Direct::SDK::Communicator} that is used for communication with the GlobalCollect service.
    #
    # @param config_file_name   [String] Path to the configuration file to use, should be in YAML format.
    # @param api_key_id         [String] Key id for the GlobalCollect service.
    # @param secret_api_key     [String] Secret key used for authentication to the GlobalCollect service.
    # @param meta_data_provider [Ingenico::Direct::SDK::MetaDataProvider,nil] stores the metadata for the communicating client.
    # @param connection         [Ingenico::Direct::SDK::Connection,nil] connection that can be used to communicate with the Ingenico Direct platform.
    # @param authenticator      [Ingenico::Direct::SDK::Authenticator,nil] authenticator that can authenticate messages sent to the Ingenico Direct platform.
    # @return [Ingenico::Direct::SDK::Communicator] The created communicator
    def self.create_communicator_from_file(config_file_name, api_key_id, secret_api_key,
                                           meta_data_provider: nil, connection: nil, authenticator: nil,
                                           marshaller: DefaultImpl::DefaultMarshaller.INSTANCE)
      configuration = create_configuration(config_file_name, api_key_id, secret_api_key)
      create_communicator_from_configuration(configuration, meta_data_provider: meta_data_provider, connection: connection,
                                             authenticator: authenticator, marshaller: marshaller)
    end

    # Creates and returns an {Ingenico::Direct::SDK::Client} that provides the a high-level interface with the GlobalCollect service.
    # If a code block is given, the created client is returned to the code block and closed afterwards.
    #
    # @example Providing a code block
    #           Factory.create_client_from_configuration(configuration) do |client|
    #             client.merchant(merchant_id).services.testconnection
    #           end
    #           # client is closed here
    #
    # @param configuration [Ingenico::Direct::SDK::CommunicatorConfiguration] contains configuration settings to be used by the client.
    # @return [Ingenico::Direct::SDK::Client] The created client
    def self.create_client_from_configuration(configuration)
      communicator = create_communicator_from_configuration(configuration)
      client = Client.new(communicator)
      if block_given?
        begin
          yield client
        ensure
          client.close
        end
      else
        return client
      end
    end

    # Creates and returns an {Ingenico::Direct::SDK::Client} that provides the a high-level interface with the GlobalCollect service.
    # If a code block is given, the created client is returned to the code block and closed afterwards.
    #
    # @example Providing a code block
    #           Factory.create_client_from_communicator(communicator) do |client|
    #             client.merchant(merchant_id).services.testconnection
    #           end
    #           # client is closed here
    #
    # @param communicator [Ingenico::Direct::SDK::Communicator] provides network communication service for the Client
    # @return [Ingenico::Direct::SDK::Client] The created client
    def self.create_client_from_communicator(communicator)
      client = Client.new(communicator)
      if block_given?
        begin
          yield client
        ensure
          client.close
        end
      else
        return client
      end
    end

    # Creates and returns an {Ingenico::Direct::SDK::Client} that provides the a high-level interface with the GlobalCollect service.
    # If a code block is given, the created client is returned to the code block and closed afterwards.
    #
    # @example Providing a code block
    #           Factory.create_client_from_file(config_file_name, api_key_id, secret_api_key) do |client|
    #             client.merchant(merchant_id).services.testconnection
    #           end
    #           # client is closed here
    #
    # @param config_file_name [String] Path to the configuration file to use, should be in YAML format.
    # @param api_key_id       [String] Key id for the GlobalCollect service.
    # @param secret_api_key   [String] Secret key used for authentication to the GlobalCollect service.
    # @return [Ingenico::Direct::SDK::Client] The created client
    def self.create_client_from_file(config_file_name, api_key_id, secret_api_key)
      communicator = create_communicator_from_file(config_file_name, api_key_id, secret_api_key)
      client = Client.new(communicator)
      if block_given?
        begin
          yield client
        ensure
          client.close
        end
      else
        return client
      end
    end
  end
end
