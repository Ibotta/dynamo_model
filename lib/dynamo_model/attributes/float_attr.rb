module DynamoModel
  module Attributes
    class FloatAttr < NumberAttr

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        value.to_f
      end

    end
  end
end
