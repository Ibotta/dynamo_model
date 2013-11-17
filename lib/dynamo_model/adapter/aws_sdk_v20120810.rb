module DynamoModel
  # sdk adapter
  #
  # @see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html
  # @see http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/DynamoDB/Client/V20120810.html
  class AwsSdkV20120810

    def self.attribute_defintion(type, name)
      { type.downcase.to_sym => name.to_s }
    end

    def self.attribute_value(type, value)
      { type.downcase.to_sym => value.to_s }
    end

    #@todo table definition, keyschema, etc
    #@todo index definition
    #@todo item definition
    #@todo expectation def

    #@todo client operations
    #@todo batch_get batch_write create_table delete_item delete_table describe_table get_item
    #@todo list_tables put_item query scan update_item update_table

  end
end
