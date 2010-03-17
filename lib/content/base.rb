#require 'tree_node_content'
#require 'stateful'
#require 'taggable'
require 'content/view'

module Content

  module Base

    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        #include TreeNodeContent
        #include Stateful
        #include Taggable
        include View
        class << self; attr_reader :schema end
        @schema = Schema.new(self.class.to_s)
      end
    end

    module ClassMethods

      def define_schema
        yield schema if block_given?
      end
    end

    def schema_fields
      self.class.schema.fields
    end
  end
end
