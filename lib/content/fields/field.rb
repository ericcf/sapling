module Content

  module Fields

    class Field

      attr_reader :name, :type, :edit_type, :object_name, :label, :required
			attr_reader :display

			class << self; attr_reader :types; end
			@types = {}

      def self.register(field_class)
				self.types[field_class.type] = field_class.to_s
      end

      def self.type
        raise 'implement in subclass!'
      end

      def self.edit_type
        raise 'implement in subclass!'
      end

      def initialize(attributes)
        @name = attributes[:name]
        @type = self.class.type
        @edit_type = attributes[:edit_type] || self.class.edit_type
        @object_name = attributes[:object_name]
        @label = attributes[:label]
        @required = attributes[:required]
				@display = attributes[:display] || 'default'
				@other = attributes[:other]
      end

      def is_file_field?
        @is_file_field || false
      end
    end
  end
end
