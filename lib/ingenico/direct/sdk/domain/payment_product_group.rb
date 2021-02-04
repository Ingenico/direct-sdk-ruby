#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'
require 'ingenico/direct/sdk/domain/account_on_file'
require 'ingenico/direct/sdk/domain/payment_product_display_hints'

module Ingenico::Direct::SDK
  module Domain

    # @attr [Ingenico::Direct::SDK::Domain::AccountOnFile] account_on_file
    # @attr [Ingenico::Direct::SDK::Domain::PaymentProductDisplayHints] display_hints
    # @attr [String] id
    class PaymentProductGroup < Ingenico::Direct::SDK::DataObject
      attr_accessor :account_on_file
      attr_accessor :display_hints
      attr_accessor :id

      # @return (Hash)
      def to_h
        hash = super
        hash['accountOnFile'] = @account_on_file.to_h if @account_on_file
        hash['displayHints'] = @display_hints.to_h if @display_hints
        hash['id'] = @id unless @id.nil?
        hash
      end

      def from_hash(hash)
        super
        if hash.key? 'accountOnFile'
          raise TypeError, "value '%s' is not a Hash" % [hash['accountOnFile']] unless hash['accountOnFile'].is_a? Hash
          @account_on_file = Ingenico::Direct::SDK::Domain::AccountOnFile.new_from_hash(hash['accountOnFile'])
        end
        if hash.key? 'displayHints'
          raise TypeError, "value '%s' is not a Hash" % [hash['displayHints']] unless hash['displayHints'].is_a? Hash
          @display_hints = Ingenico::Direct::SDK::Domain::PaymentProductDisplayHints.new_from_hash(hash['displayHints'])
        end
        @id = hash['id'] if hash.key? 'id'
      end
    end
  end
end
