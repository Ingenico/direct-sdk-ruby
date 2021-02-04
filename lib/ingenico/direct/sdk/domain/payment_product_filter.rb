#
# This class was auto-generated from the API references found at
# https://support.direct.ingenico.com/documentation/api/reference/
#
require 'ingenico/direct/sdk/data_object'

module Ingenico::Direct::SDK
  module Domain

    # @attr [Array<String>] groups
    # @attr [Array<Integer>] products
    class PaymentProductFilter < Ingenico::Direct::SDK::DataObject
      attr_accessor :groups
      attr_accessor :products

      # @return (Hash)
      def to_h
        hash = super
        hash['groups'] = @groups unless @groups.nil?
        hash['products'] = @products unless @products.nil?
        hash
      end

      def from_hash(hash)
        super
        if hash.key? 'groups'
          raise TypeError, "value '%s' is not an Array" % [hash['groups']] unless hash['groups'].is_a? Array
          @groups = []
          hash['groups'].each do |e|
            @groups << e
          end
        end
        if hash.key? 'products'
          raise TypeError, "value '%s' is not an Array" % [hash['products']] unless hash['products'].is_a? Array
          @products = []
          hash['products'].each do |e|
            @products << e
          end
        end
      end
    end
  end
end
