module DynamoModel
  module Model

    # Attribute methods
    # @todo mass assignment / protected attribs protection
    module Attributes
      extend ActiveSupport::Concern

      module ClassMethods

      end #/end ClassMethods

      #InstanceMethods

      # set attributes as hash
      #
      # @params [Hash] attribs key/values to set
      def attributes=(attribs={})
        attribs.each do |k, v|
          write_attribute(k, v)
        end
      end

      # get attributes as a hash
      #
      # @return [Hash]
      def attributes
        @attributes.keys.each_with_object({}) do |k, hsh|
          hsh[k] = read_attribute(k)
        end
      end

      # read out a single attribute
      #
      # @param [Symbol] name
      def read_attribute(name)
        #simply return from attributes
        @attributes[name.to_sym]
      end
      # alias_method :[], :read_attribute

      # set a single attribute
      #
      # @param [Symbol] name
      # @param value
      def write_attribute(name, value=nil)
        #write attribute, marking dirty
        attribute_will_change!(name.to_sym)
        @attributes[name.to_sym] = value
      end
      # alias_method :[]=, :write_attribute

      def inspect
        "#<#{self} #{self.attributes.to_s}>"
      end

      #/end InstanceMethods

    end #/end Attributes
  end
end
