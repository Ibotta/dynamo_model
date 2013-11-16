module DynamoModel
  module Model

    #Mixin for table-specific methods on a model
    module Table
      extend ActiveSupport::Concern

      module ClassMethods

        # [Hash<Symbol, DynamoType>] list of all column definitions
        def columns
          @columns
        end

        # Define the table configuration key (table name)  This or a definition block is required
        #
        # @param [String, Symbol] key for configuration lookup about this table
        # @todo
        def table_name(key = nil)
          key ||= self.model_name.pluralize
          definition(Config.config.table_definitions[definition_key])
        end

        # Defines the table configuration.  Can be given a Definition object or be a block given a new Definition
        #
        # This method actually performs the definition
        #
        # @param [Definition] d definition object
        # @yield a new definition block to be filled for this class
        # @yieldparam d [Definition] definition to use
        #
        # @todo needs a mutex around any classvar assignments
        def definition(d = nil)
          @columns = {}
          @definition = d || Definition.new

          raise NameError, "Table #{definition_key} not defined" unless @definition and @definition.valid?

          @table_name = d.table_name || self.model_name.pluralize

          #use attributes
          @columns = d.attrs
          @columns.each { |key, at| define_attribute(key) }
          define_attribute_methods(columns.keys)

          self
        end

        protected

        def define_attribute(name)
          define_method(name) do
            read_attribute(name)
          end
          define_method("#{name}=".to_sym) do |val|
            write_attribute(name, val)
          end
        end

      end #/end ClassMethods

      #InstanceMethods

      #/end InstanceMethods

    end  #/end Table
  end
end
