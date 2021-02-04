#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'
require 'ingenico/direct/sdk/domain/address_personal'

module Ingenico::Direct::SDK
  module Domain

    # @attr [Ingenico::Direct::SDK::Domain::AddressPersonal] address
    # @attr [String] address_indicator
    # @attr [String] email_address
    # @attr [String] first_usage_date
    # @attr [true/false] is_first_usage
    # @attr [String] type
    class Shipping < Ingenico::Direct::SDK::DataObject
      attr_accessor :address
      attr_accessor :address_indicator
      attr_accessor :email_address
      attr_accessor :first_usage_date
      attr_accessor :is_first_usage
      attr_accessor :type

      # @return (Hash)
      def to_h
        hash = super
        hash['address'] = @address.to_h if @address
        hash['addressIndicator'] = @address_indicator unless @address_indicator.nil?
        hash['emailAddress'] = @email_address unless @email_address.nil?
        hash['firstUsageDate'] = @first_usage_date unless @first_usage_date.nil?
        hash['isFirstUsage'] = @is_first_usage unless @is_first_usage.nil?
        hash['type'] = @type unless @type.nil?
        hash
      end

      def from_hash(hash)
        super
        if hash.key? 'address'
          raise TypeError, "value '%s' is not a Hash" % [hash['address']] unless hash['address'].is_a? Hash
          @address = Ingenico::Direct::SDK::Domain::AddressPersonal.new_from_hash(hash['address'])
        end
        @address_indicator = hash['addressIndicator'] if hash.key? 'addressIndicator'
        @email_address = hash['emailAddress'] if hash.key? 'emailAddress'
        @first_usage_date = hash['firstUsageDate'] if hash.key? 'firstUsageDate'
        @is_first_usage = hash['isFirstUsage'] if hash.key? 'isFirstUsage'
        @type = hash['type'] if hash.key? 'type'
      end
    end
  end
end
