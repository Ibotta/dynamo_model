require_relative 'string_attr'

module DynamoModel
  module Attributes
    class DatetimeAttr < StringAttr

      # convert value to the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def to_dynamo_value(value)
        value.iso8601
      end

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        DateTime.parse(value)
      end

    end
  end
end
