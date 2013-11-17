require_relative 'string_attr'

module DynamoModel
  module Attributes
    class SymbolAttr < StringAttr

      # convert value to the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def to_dynamo_value(value)
        super(value.to_sym)
      end

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        value.to_sym
      end

    end
  end
end
