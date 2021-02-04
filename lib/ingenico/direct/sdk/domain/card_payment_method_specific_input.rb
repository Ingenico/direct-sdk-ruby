#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'
require 'ingenico/direct/sdk/domain/card'
require 'ingenico/direct/sdk/domain/card_recurrence_details'
require 'ingenico/direct/sdk/domain/three_d_secure'

module Ingenico::Direct::SDK
  module Domain

    # @attr [String] authorization_mode
    # @attr [Ingenico::Direct::SDK::Domain::Card] card
    # @attr [String] initial_scheme_transaction_id
    # @attr [true/false] is_recurring
    # @attr [Integer] payment_product_id
    # @attr [Ingenico::Direct::SDK::Domain::CardRecurrenceDetails] recurring
    # @attr [String] return_url
    # @attr [true/false] skip_authentication
    # @attr [true/false] skip_soft_decline
    # @attr [Ingenico::Direct::SDK::Domain::ThreeDSecure] three_d_secure
    # @attr [String] token
    # @attr [true/false] tokenize
    # @attr [String] transaction_channel
    # @attr [String] unscheduled_card_on_file_requestor
    # @attr [String] unscheduled_card_on_file_sequence_indicator
    class CardPaymentMethodSpecificInput < Ingenico::Direct::SDK::DataObject
      attr_accessor :authorization_mode
      attr_accessor :card
      attr_accessor :initial_scheme_transaction_id
      attr_accessor :is_recurring
      attr_accessor :payment_product_id
      attr_accessor :recurring
      attr_accessor :return_url
      attr_accessor :skip_authentication
      attr_accessor :skip_soft_decline
      attr_accessor :three_d_secure
      attr_accessor :token
      attr_accessor :tokenize
      attr_accessor :transaction_channel
      attr_accessor :unscheduled_card_on_file_requestor
      attr_accessor :unscheduled_card_on_file_sequence_indicator

      # @return (Hash)
      def to_h
        hash = super
        hash['authorizationMode'] = @authorization_mode unless @authorization_mode.nil?
        hash['card'] = @card.to_h if @card
        hash['initialSchemeTransactionId'] = @initial_scheme_transaction_id unless @initial_scheme_transaction_id.nil?
        hash['isRecurring'] = @is_recurring unless @is_recurring.nil?
        hash['paymentProductId'] = @payment_product_id unless @payment_product_id.nil?
        hash['recurring'] = @recurring.to_h if @recurring
        hash['returnUrl'] = @return_url unless @return_url.nil?
        hash['skipAuthentication'] = @skip_authentication unless @skip_authentication.nil?
        hash['skipSoftDecline'] = @skip_soft_decline unless @skip_soft_decline.nil?
        hash['threeDSecure'] = @three_d_secure.to_h if @three_d_secure
        hash['token'] = @token unless @token.nil?
        hash['tokenize'] = @tokenize unless @tokenize.nil?
        hash['transactionChannel'] = @transaction_channel unless @transaction_channel.nil?
        hash['unscheduledCardOnFileRequestor'] = @unscheduled_card_on_file_requestor unless @unscheduled_card_on_file_requestor.nil?
        hash['unscheduledCardOnFileSequenceIndicator'] = @unscheduled_card_on_file_sequence_indicator unless @unscheduled_card_on_file_sequence_indicator.nil?
        hash
      end

      def from_hash(hash)
        super
        @authorization_mode = hash['authorizationMode'] if hash.key? 'authorizationMode'
        if hash.key? 'card'
          raise TypeError, "value '%s' is not a Hash" % [hash['card']] unless hash['card'].is_a? Hash
          @card = Ingenico::Direct::SDK::Domain::Card.new_from_hash(hash['card'])
        end
        @initial_scheme_transaction_id = hash['initialSchemeTransactionId'] if hash.key? 'initialSchemeTransactionId'
        @is_recurring = hash['isRecurring'] if hash.key? 'isRecurring'
        @payment_product_id = hash['paymentProductId'] if hash.key? 'paymentProductId'
        if hash.key? 'recurring'
          raise TypeError, "value '%s' is not a Hash" % [hash['recurring']] unless hash['recurring'].is_a? Hash
          @recurring = Ingenico::Direct::SDK::Domain::CardRecurrenceDetails.new_from_hash(hash['recurring'])
        end
        @return_url = hash['returnUrl'] if hash.key? 'returnUrl'
        @skip_authentication = hash['skipAuthentication'] if hash.key? 'skipAuthentication'
        @skip_soft_decline = hash['skipSoftDecline'] if hash.key? 'skipSoftDecline'
        if hash.key? 'threeDSecure'
          raise TypeError, "value '%s' is not a Hash" % [hash['threeDSecure']] unless hash['threeDSecure'].is_a? Hash
          @three_d_secure = Ingenico::Direct::SDK::Domain::ThreeDSecure.new_from_hash(hash['threeDSecure'])
        end
        @token = hash['token'] if hash.key? 'token'
        @tokenize = hash['tokenize'] if hash.key? 'tokenize'
        @transaction_channel = hash['transactionChannel'] if hash.key? 'transactionChannel'
        @unscheduled_card_on_file_requestor = hash['unscheduledCardOnFileRequestor'] if hash.key? 'unscheduledCardOnFileRequestor'
        @unscheduled_card_on_file_sequence_indicator = hash['unscheduledCardOnFileSequenceIndicator'] if hash.key? 'unscheduledCardOnFileSequenceIndicator'
      end
    end
  end
end
