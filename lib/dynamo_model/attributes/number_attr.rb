require_relative 'base'

module DynamoModel
  module Attributes
    class NumberAttr < Base

      DYNAMO_TYPE = 'N'

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        raise NotImplementedError, 'Must be a non-abstract number'
      end

    end
  end
end
