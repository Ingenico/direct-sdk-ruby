#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'
require 'ingenico/direct/sdk/domain/fraud_results'
require 'ingenico/direct/sdk/domain/payment_product771_specific_output'

module Ingenico::Direct::SDK
  module Domain

    # @attr [Ingenico::Direct::SDK::Domain::FraudResults] fraud_results
    # @attr [Ingenico::Direct::SDK::Domain::PaymentProduct771SpecificOutput] payment_product771_specific_output
    # @attr [Integer] payment_product_id
    class SepaDirectDebitPaymentMethodSpecificOutput < Ingenico::Direct::SDK::DataObject
      attr_accessor :fraud_results
      attr_accessor :payment_product771_specific_output
      attr_accessor :payment_product_id

      # @return (Hash)
      def to_h
        hash = super
        hash['fraudResults'] = @fraud_results.to_h if @fraud_results
        hash['paymentProduct771SpecificOutput'] = @payment_product771_specific_output.to_h if @payment_product771_specific_output
        hash['paymentProductId'] = @payment_product_id unless @payment_product_id.nil?
        hash
      end

      def from_hash(hash)
        super
        if hash.key? 'fraudResults'
          raise TypeError, "value '%s' is not a Hash" % [hash['fraudResults']] unless hash['fraudResults'].is_a? Hash
          @fraud_results = Ingenico::Direct::SDK::Domain::FraudResults.new_from_hash(hash['fraudResults'])
        end
        if hash.key? 'paymentProduct771SpecificOutput'
          raise TypeError, "value '%s' is not a Hash" % [hash['paymentProduct771SpecificOutput']] unless hash['paymentProduct771SpecificOutput'].is_a? Hash
          @payment_product771_specific_output = Ingenico::Direct::SDK::Domain::PaymentProduct771SpecificOutput.new_from_hash(hash['paymentProduct771SpecificOutput'])
        end
        @payment_product_id = hash['paymentProductId'] if hash.key? 'paymentProductId'
      end
    end
  end
end
