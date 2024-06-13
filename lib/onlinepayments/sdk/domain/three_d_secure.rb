#
# This class was auto-generated.
#
require 'onlinepayments/sdk/data_object'
require 'onlinepayments/sdk/domain/external_cardholder_authentication_data'
require 'onlinepayments/sdk/domain/redirection_data'
require 'onlinepayments/sdk/domain/three_ds_whitelist'
require 'onlinepayments/sdk/domain/three_d_secure_data'

module OnlinePayments::SDK
  module Domain

    # @attr [Long] authentication_amount
    # @attr [String] challenge_canvas_size
    # @attr [String] challenge_indicator
    # @attr [true/false] decoupled_indicator
    # @attr [String] decoupled_max_time
    # @attr [String] exemption_request
    # @attr [OnlinePayments::SDK::Domain::ExternalCardholderAuthenticationData] external_cardholder_authentication_data
    # @attr [Integer] merchant_fraud_rate
    # @attr [String] payment_token_source
    # @attr [OnlinePayments::SDK::Domain::ThreeDSecureData] prior_three_d_secure_data
    # @attr [OnlinePayments::SDK::Domain::RedirectionData] redirection_data
    # @attr [true/false] secure_corporate_payment
    # @attr [true/false] skip_authentication
    # @attr [true/false] skip_soft_decline
    # @attr [String] three_ri_indicator
    # @attr [OnlinePayments::SDK::Domain::ThreeDSWhitelist] whitelist
    class ThreeDSecure < OnlinePayments::SDK::DataObject
      attr_accessor :authentication_amount
      attr_accessor :challenge_canvas_size
      attr_accessor :challenge_indicator
      attr_accessor :decoupled_indicator
      attr_accessor :decoupled_max_time
      attr_accessor :exemption_request
      attr_accessor :external_cardholder_authentication_data
      attr_accessor :merchant_fraud_rate
      attr_accessor :payment_token_source
      attr_accessor :prior_three_d_secure_data
      attr_accessor :redirection_data
      attr_accessor :secure_corporate_payment
      attr_accessor :skip_authentication
      attr_accessor :skip_soft_decline
      attr_accessor :three_ri_indicator
      attr_accessor :whitelist

      # @return (Hash)
      def to_h
        hash = super
        hash['authenticationAmount'] = @authentication_amount unless @authentication_amount.nil?
        hash['challengeCanvasSize'] = @challenge_canvas_size unless @challenge_canvas_size.nil?
        hash['challengeIndicator'] = @challenge_indicator unless @challenge_indicator.nil?
        hash['decoupledIndicator'] = @decoupled_indicator unless @decoupled_indicator.nil?
        hash['decoupledMaxTime'] = @decoupled_max_time unless @decoupled_max_time.nil?
        hash['exemptionRequest'] = @exemption_request unless @exemption_request.nil?
        hash['externalCardholderAuthenticationData'] = @external_cardholder_authentication_data.to_h if @external_cardholder_authentication_data
        hash['merchantFraudRate'] = @merchant_fraud_rate unless @merchant_fraud_rate.nil?
        hash['paymentTokenSource'] = @payment_token_source unless @payment_token_source.nil?
        hash['priorThreeDSecureData'] = @prior_three_d_secure_data.to_h if @prior_three_d_secure_data
        hash['redirectionData'] = @redirection_data.to_h if @redirection_data
        hash['secureCorporatePayment'] = @secure_corporate_payment unless @secure_corporate_payment.nil?
        hash['skipAuthentication'] = @skip_authentication unless @skip_authentication.nil?
        hash['skipSoftDecline'] = @skip_soft_decline unless @skip_soft_decline.nil?
        hash['threeRIIndicator'] = @three_ri_indicator unless @three_ri_indicator.nil?
        hash['whitelist'] = @whitelist.to_h if @whitelist
        hash
      end

      def from_hash(hash)
        super
        @authentication_amount = hash['authenticationAmount'] if hash.key? 'authenticationAmount'
        @challenge_canvas_size = hash['challengeCanvasSize'] if hash.key? 'challengeCanvasSize'
        @challenge_indicator = hash['challengeIndicator'] if hash.key? 'challengeIndicator'
        @decoupled_indicator = hash['decoupledIndicator'] if hash.key? 'decoupledIndicator'
        @decoupled_max_time = hash['decoupledMaxTime'] if hash.key? 'decoupledMaxTime'
        @exemption_request = hash['exemptionRequest'] if hash.key? 'exemptionRequest'
        if hash.key? 'externalCardholderAuthenticationData'
          raise TypeError, "value '%s' is not a Hash" % [hash['externalCardholderAuthenticationData']] unless hash['externalCardholderAuthenticationData'].is_a? Hash
          @external_cardholder_authentication_data = OnlinePayments::SDK::Domain::ExternalCardholderAuthenticationData.new_from_hash(hash['externalCardholderAuthenticationData'])
        end
        @merchant_fraud_rate = hash['merchantFraudRate'] if hash.key? 'merchantFraudRate'
        @payment_token_source = hash['paymentTokenSource'] if hash.key? 'paymentTokenSource'
        if hash.key? 'priorThreeDSecureData'
          raise TypeError, "value '%s' is not a Hash" % [hash['priorThreeDSecureData']] unless hash['priorThreeDSecureData'].is_a? Hash
          @prior_three_d_secure_data = OnlinePayments::SDK::Domain::ThreeDSecureData.new_from_hash(hash['priorThreeDSecureData'])
        end
        if hash.key? 'redirectionData'
          raise TypeError, "value '%s' is not a Hash" % [hash['redirectionData']] unless hash['redirectionData'].is_a? Hash
          @redirection_data = OnlinePayments::SDK::Domain::RedirectionData.new_from_hash(hash['redirectionData'])
        end
        @secure_corporate_payment = hash['secureCorporatePayment'] if hash.key? 'secureCorporatePayment'
        @skip_authentication = hash['skipAuthentication'] if hash.key? 'skipAuthentication'
        @skip_soft_decline = hash['skipSoftDecline'] if hash.key? 'skipSoftDecline'
        @three_ri_indicator = hash['threeRIIndicator'] if hash.key? 'threeRIIndicator'
        if hash.key? 'whitelist'
          raise TypeError, "value '%s' is not a Hash" % [hash['whitelist']] unless hash['whitelist'].is_a? Hash
          @whitelist = OnlinePayments::SDK::Domain::ThreeDSWhitelist.new_from_hash(hash['whitelist'])
        end
      end
    end
  end
end
