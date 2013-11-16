require 'dynamo_model/model/attributes'
require 'dynamo_model/model/table'
require 'dynamo_model/model/persistence'

module DynamoModel

  # The DynamoModel base class. Acts like an ActiveModel
  class Base

    # Pull in active model behavior without a db table

    include ActiveModel::Validations
    include ActiveModel::Serialization
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Dirty #includes AttributeMethods already
    extend ActiveModel::Callbacks

    #our methods

    include Model::Attributes
    include Model::Table
    include Model::Persistence

    #todo move to mixin
    #implementation methods

    def to_key
      #todo change to hash(/range if defined)
      persisted? ? [id] : nil
    end

    #base methods

    # Model initializer. Will assign the attribute hash if specified
    #
    # @param [Hash] attributes new model attributes
    # @param [Hash] opts options to set on the model
    # @option opts [String] :dirty (false) trigger dirty on changes from attributes
    def initialize(attributes=nil, options={})
      @attributes = {}
      #todo dirty flagging
      #todo use attributes=
      #todo use keys from defined?
      @attributes = attributes if attributes.present?
    end

  end #/end Base

end
