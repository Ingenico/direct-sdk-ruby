#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'

module Ingenico::Direct::SDK
  module Domain

    # @attr [String] card_number
    # @attr [String] expiry_date
    class CardEssentials < Ingenico::Direct::SDK::DataObject
      attr_accessor :card_number
      attr_accessor :expiry_date

      # @return (Hash)
      def to_h
        hash = super
        hash['cardNumber'] = @card_number unless @card_number.nil?
        hash['expiryDate'] = @expiry_date unless @expiry_date.nil?
        hash
      end

      def from_hash(hash)
        super
        @card_number = hash['cardNumber'] if hash.key? 'cardNumber'
        @expiry_date = hash['expiryDate'] if hash.key? 'expiryDate'
      end
    end
  end
end
