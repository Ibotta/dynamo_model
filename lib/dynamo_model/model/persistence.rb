module DynamoModel
  module Model

    # Persistence methods
    # @todo actual delegation
    # @todo save @previously_changed in save/update
    # @todo how to manage persisted?/new_record?
    module Persistence
      extend ActiveSupport::Concern

      module ClassMethods

        def adapter

        end

      end #/end ClassMethods

      #InstanceMethods

      # return the dynamo list of values
      # @see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutItem.html#API_PutItem_RequestSyntax Item
      #
      # @return [Hash]
      def to_dynamo_value_hash
        self.attributes.each_with_index({}) do |k, v|
          self.class.columns[k].to_dynamo_value_hash(v)
        end
      end

      # set attributes based on dynamo items. does not run dirty
      # @see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_GetItem.html#API_GetItem_RequestSyntax Key
      #
      # @return [Hash]
      # @todo what to do with unknown keys
      def from_dynamo_value_hash(item_attribs)
        item_attribs.each do |key, val|
          key = key.to_sym
          raise if self.class.columns[key].nil?
          @attribute[key] = self.class.columns[key].from_dynamo_value_hash(val)
        end
      end

      def persisted?
        #todo
        false
      end

      def save
      end
      def save!
      end
      def destroy
      end
      def destroy!
      end

      #/end InstanceMethods


    end #/end Persistence
  end
end
