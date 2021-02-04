#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'

module Ingenico::Direct::SDK
  module Domain

    # @attr [Integer] display_order
    # @attr [String] label
    # @attr [String] logo
    class PaymentProductDisplayHints < Ingenico::Direct::SDK::DataObject
      attr_accessor :display_order
      attr_accessor :label
      attr_accessor :logo

      # @return (Hash)
      def to_h
        hash = super
        hash['displayOrder'] = @display_order unless @display_order.nil?
        hash['label'] = @label unless @label.nil?
        hash['logo'] = @logo unless @logo.nil?
        hash
      end

      def from_hash(hash)
        super
        @display_order = hash['displayOrder'] if hash.key? 'displayOrder'
        @label = hash['label'] if hash.key? 'label'
        @logo = hash['logo'] if hash.key? 'logo'
      end
    end
  end
end
