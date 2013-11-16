require "dynamo_model/version"
require 'active_support'
require 'active_model'

require 'dynamo_model/base'
require 'dynamo_model/config'

module DynamoModel

  def self.configure(&block)
    DynamoModel::Config.configure(&block)
  end

  def self.base
    DynamoModel::Base
  end

end
