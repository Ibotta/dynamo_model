module DynamoModel
  module Model

    #Mixin for table-specific methods on a model
    module Table
      extend ActiveSupport::Concern


      module ClassMethods

        attr_reader :table_name

        # returns the table name
        # @return [String]
        # @todo may need mutex in setting case, or not do it this way
        def table_name
          @table_name ||= self.model_name.pluralize
        end

        # @return [Hash<Symbol, DynamoType>] list of all column definitions
        def columns
          @columns
        end

        # Define the table configuration key (table name)  This or a definition block is required
        #
        # @param [String, Symbol] key for configuration lookup about this table
        # @todo make this work w/ config
        # @todo not sure I like the naming of this vs setting instance table_name
        def set_table_name(key = nil)
          key ||= self.table_name
          definition(Config.config.table_definitions[key])
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
        # @todo not sure I like the naming of this vs storage of the defn instance
        # @todo different exception type?
        def definition(d = nil)
          @columns = {}
          @definition = (d ||= Definition.new)

          yield(@definition) if block_given?

          raise NameError, "Table not defined" unless @definition and @definition.valid?

          @table_name = @definition.table_name

          #use attributes
          @columns = @definition.attrs
          @columns.each { |key, at| define_attribute(key) }
          define_attribute_methods(columns.keys)

          self
        end

        protected

        # Define an attribute
        #
        # @param [Symbol] name attribute name
        # @todo how do sets get handled
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
