module DynamoModel

  # global configuration
  # @todo figure out how to persist this like schema.rb does
  # @todo configure adapter
  class Config
    include ActiveSupport::Configurable

    config_accessor :table_definitions
    config_accessor :aws_global
    # config_accessor

  end
end
