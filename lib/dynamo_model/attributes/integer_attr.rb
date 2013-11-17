require_relative 'number_attr'

module DynamoModel
  module Attributes
    class IntegerAttr < NumberAttr

      # convert value to the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def to_dynamo_value(value)
        super(value.to_i)
      end

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        value.to_i
      end

    end
  end
end
