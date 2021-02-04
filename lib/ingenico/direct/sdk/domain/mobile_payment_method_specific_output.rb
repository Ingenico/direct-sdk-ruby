#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'
require 'ingenico/direct/sdk/domain/card_fraud_results'
require 'ingenico/direct/sdk/domain/mobile_payment_data'
require 'ingenico/direct/sdk/domain/three_d_secure_results'

module Ingenico::Direct::SDK
  module Domain

    # @attr [String] authorisation_code
    # @attr [Ingenico::Direct::SDK::Domain::CardFraudResults] fraud_results
    # @attr [String] network
    # @attr [Ingenico::Direct::SDK::Domain::MobilePaymentData] payment_data
    # @attr [Integer] payment_product_id
    # @attr [Ingenico::Direct::SDK::Domain::ThreeDSecureResults] three_d_secure_results
    class MobilePaymentMethodSpecificOutput < Ingenico::Direct::SDK::DataObject
      attr_accessor :authorisation_code
      attr_accessor :fraud_results
      attr_accessor :network
      attr_accessor :payment_data
      attr_accessor :payment_product_id
      attr_accessor :three_d_secure_results

      # @return (Hash)
      def to_h
        hash = super
        hash['authorisationCode'] = @authorisation_code unless @authorisation_code.nil?
        hash['fraudResults'] = @fraud_results.to_h if @fraud_results
        hash['network'] = @network unless @network.nil?
        hash['paymentData'] = @payment_data.to_h if @payment_data
        hash['paymentProductId'] = @payment_product_id unless @payment_product_id.nil?
        hash['threeDSecureResults'] = @three_d_secure_results.to_h if @three_d_secure_results
        hash
      end

      def from_hash(hash)
        super
        @authorisation_code = hash['authorisationCode'] if hash.key? 'authorisationCode'
        if hash.key? 'fraudResults'
          raise TypeError, "value '%s' is not a Hash" % [hash['fraudResults']] unless hash['fraudResults'].is_a? Hash
          @fraud_results = Ingenico::Direct::SDK::Domain::CardFraudResults.new_from_hash(hash['fraudResults'])
        end
        @network = hash['network'] if hash.key? 'network'
        if hash.key? 'paymentData'
          raise TypeError, "value '%s' is not a Hash" % [hash['paymentData']] unless hash['paymentData'].is_a? Hash
          @payment_data = Ingenico::Direct::SDK::Domain::MobilePaymentData.new_from_hash(hash['paymentData'])
        end
        @payment_product_id = hash['paymentProductId'] if hash.key? 'paymentProductId'
        if hash.key? 'threeDSecureResults'
          raise TypeError, "value '%s' is not a Hash" % [hash['threeDSecureResults']] unless hash['threeDSecureResults'].is_a? Hash
          @three_d_secure_results = Ingenico::Direct::SDK::Domain::ThreeDSecureResults.new_from_hash(hash['threeDSecureResults'])
        end
      end
    end
  end
end
