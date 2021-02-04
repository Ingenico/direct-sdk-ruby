#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'

module Ingenico::Direct::SDK
  module Domain

    # @attr [String] id
    # @attr [String] label
    # @attr [String] type
    # @attr [String] value
    class PaymentProductFieldDisplayElement < Ingenico::Direct::SDK::DataObject
      attr_accessor :id
      attr_accessor :label
      attr_accessor :type
      attr_accessor :value

      # @return (Hash)
      def to_h
        hash = super
        hash['id'] = @id unless @id.nil?
        hash['label'] = @label unless @label.nil?
        hash['type'] = @type unless @type.nil?
        hash['value'] = @value unless @value.nil?
        hash
      end

      def from_hash(hash)
        super
        @id = hash['id'] if hash.key? 'id'
        @label = hash['label'] if hash.key? 'label'
        @type = hash['type'] if hash.key? 'type'
        @value = hash['value'] if hash.key? 'value'
      end
    end
  end
end
