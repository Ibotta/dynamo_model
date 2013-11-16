module DynamoModel
  class Config
    include ActiveSupport::Configurable

    config_accessor :table_definitions
    config_accessor :aws_global
    # config_accessor

  end
end
