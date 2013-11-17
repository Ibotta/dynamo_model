module DynamoModel
  module Attributes

    # Attributes define the serialization and type conversion for a given column
    #
    # @todo value caching
    # @todo need to handle sets
    # @todo need to handle binary versions
    class Base

      DYNAMO_TYPE = 'S'

      attr_reader :name, :opts

      # new attribute
      #
      # @param [Symbol] name name of this attribute
      # @param [Hash] opts serialization options (see specific implementation)
      def initialize(name, opts = {})
        @name = name
        @opts = options
      end

      # convert value to the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def to_dynamo_value(value)
        value.to_s
      end

      # convert value from the value to be stored in DynamoDB.  Not adapter specific.
      #
      # @param value value to convert
      def from_dynamo_value(value)
        value.to_s
      end

      # convert value to api AttributeDefinition.  Adapter specific, so delegates to converter
      # @see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeDefinition.html
      #
      # @param value value to convert
      # @todo delegate to adapter
      def to_dynamo_hash(value)
        #adapter.attribute_definition(DYNAMO_TYPE, to_dynamo_value)
        { DYNAMO_TYPE.downcase.to_sym => to_dynamo_value(value) }
      end

      # convert AttributeDefinition to a value.  Adapter specific, so delegates to converter
      # @see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html
      #
      # @param value value to convert
      # @todo delegate to adapter
      def from_dynamo_hash(from)
        #adapter.attribute_value(DYNAMO_TYPE, to_dynamo_value)
        type, value = from.first
        if type.to_s.upcase != DYNAMO_TYPE
          #TODO logger warning? Exception?
          raise
        end
        from_dynamo_value(value)
      end

    end
  end
end
