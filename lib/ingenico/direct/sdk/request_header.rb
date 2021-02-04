module Ingenico::Direct::SDK

  # Represents HTTP request headers
  # Each header is immutable has a #name and #value attribute
  #
  # @attr_reader [String] name  HTTP header name
  # @attr_reader [String] value HTTP header value
  class RequestHeader

    # Create a new header using the name and value given as parameters.
    def initialize(name, value)
      raise ArgumentError, 'name is required' if name.nil? || name.strip.empty?
      @name = name
      @value = normalize_value(value)
    end

    attr_reader :name
    attr_reader :value

    def to_s
      "#{name}:#{value}"
    end

    # Return the {Ingenico::Direct::SDK::ResponseHeader} that goes by the given _header_name_,
    # If this Response does not contain a header with the given name, return _nil_ instead
    def self.get_header(headers, header_name)
        selected_headers = headers.select { |h| h.name == header_name }
        return selected_headers&.length.positive? ?
                   selected_headers[0] :
                   nil
    end

    # Returns the header value of the header that goes by the given _header_name_,
    # If this response does not contain a header with the given name, return _nil_ instead
    def self.get_header_value(headers, header_name)
        return get_header(headers, header_name)&.value
    end

    private

    def normalize_value(value)
      return value if value.nil? || value.empty?
      # Replace all sequences of whitespace*-linebreak-whitespace* into a single linebreak-space
      # This will ensure that:
      # - no line ends with whitespace, because this causes authentication failures
      # - each line starts with a single whitespace, so it is a valid header value
      value.gsub(/[\s&&[^\r\n]]*(\r?\n)[\s&&[^\r\n]]*/, '\1 ')
    end
  end
end
