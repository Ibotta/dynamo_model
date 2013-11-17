require_relative 'attributes/datetime_attr'
require_relative 'attributes/float_attr'
require_relative 'attributes/integer_attr'
require_relative 'attributes/number_attr'
require_relative 'attributes/string_attr'
require_relative 'attributes/symbol_attr'
# @todo easier way to require all?

module DynamoModel

  # Defines a DynamoDB Table.  Has methods to define the keys, attribs, parameters
  # @todo setup client version here?
  # @todo index setup
  # @todo initial capacity setup
  # @todo adapter attach somehow
  class Definition

    attr_reader :table_name, :attrs, :keys, :capacity, :indexes

    # new definition
    #
    # @param [Hash] definition_hash pre-initialize definition with a hash.  Usually from config
    def initialize(definition_hash=nil)
      @attrs = {}
      @keys = {}
      @capacity = {}
      @indexes = {}

      if definition_hash
        # @todo process definition hash
      end
    end

    # set table capacity
    #
    # @todo possibly methods to estimate-track this via cache
    # @param [Integer] read read capacity value
    # @param [Integer] write write capacity value
    def capacity(read=nil, write=nil)
      unless read.nil? and write.nil?
        @capacity[:read] = read
        @capacity[:write] = write
      end
      @capacity
    end

    #validate the definition
    def valid?
      @attrs.size > 0 and @keys.size > 0 and !@keys[:hash].nil?
    end

    # table name
    #
    # @param [Symbol, String] name of table
    def table_name(name = nil)
      @table_name = name.to_s if !name.nil?
      @table_name
    end

    # hash key definition
    #
    # @param [Symbol] key name of attribute
    # @param [Symbol] type type of attribute (see available types)
    # @param [Hash] opts options passed to attribute (see attribute)
    def hash_key(key, type, opts={})
      key = key.to_sym
      @keys[:hash] = key
      self.send(type.to_sym, key, opts)
    end

    # range key definition
    #
    # @param [Symbol] key name of attribute
    # @param [Symbol] type type of attribute (see available types)
    # @param [Hash] opts options passed to attribute (see attribute)
    def range_key(key, type, opts={})
      key = key.to_sym
      @keys[:range] = key
      self.send(type.to_sym, key, opts)
    end

    # attribute definition
    #
    # @param [Symbol] key name of attribute
    # @param [Symbol] type type of attribute (see available types)
    # @param [Hash] opts options passed to attribute (see attribute)
    def attribute(key, type, opts={})
      self.send(type.to_sym, key, opts)
    end

    # string attribute definition. Converts everything to string thats assigned via to_s by default. method instead of to_s can be defined
    #
    # @param [Symbol] key name of attribute
    # @param [Hash] opts options passed to attribute (see attribute)
    def string(key, opts={})
      @attrs[key.to_sym] = Attributes::StringAttr.new(key, opts)
    end

    # string attribute definition. Converts everything to a symbol
    #
    # @param [Symbol] key name of attribute
    # @param [Hash] opts options passed to attribute (see attribute)
    def symbol(key, opts={})
      @attrs[key.to_sym] = Attributes::SymbolAttr.new(key, opts)
    end

    # number attribute definition. Converts to a Integer
    #
    # @param [Symbol] key name of attribute
    # @param [Hash] opts options passed to attribute (see attribute)
    def integer(key, opts={})
      @attrs[key.to_sym] = Attributes::IntegerAttr.new(key, opts)
    end

    # number attribute definition. Converts to a Float
    #
    # @param [Symbol] key name of attribute
    # @param [Hash] opts options passed to attribute (see attribute)
    def float(key, opts={})
      @attrs[key.to_sym] = Attributes::FloatAttr.new(key, opts)
    end

    # datetime attribute definition. Converts to a string for storage via ISO8601 (UTC?). format can be defined instead
    #
    # @todo use rails/system timezone instead?
    # @param [Symbol] key name of attribute
    # @param [Hash] opts options passed to attribute (see attribute)
    def datetime(key, opts={})
      @attrs[key.to_sym] = Attributes::DatetimeAttr.new(key, opts)
    end

    # automatically add created_at updated_at attributes as datetime
    #
    # @param [Hash] opts options passed to attribute (see attribute)
    def timestamps(opts={})
      @attrs[:created_at] = Attributes::DatetimeAttr.new(:created_at, opts)
      @attrs[:updated_at] = Attributes::DatetimeAttr.new(:updated_at, opts)
      nil
    end

  end
end
