require 'content/fields'

module Content

  class Schema

    attr_reader :fields

    def initialize(content_classname, fields=[])
      @content_classname = content_classname
      @fields = fields
    end

    def has_file_field?
      @fields.any? { |field| field.is_file_field? }
    end

    def method_missing(symbol, name, options={})
      add_field(name, symbol.to_s, options)
    end

    def add_field(name, type, options)
      attributes = {
              :name => name,
              :object_name => @content_classname.underscore
      }.merge(options)
      field_class = eval(Content::Fields::Field.types[type])
      @fields << field_class.new(
              attributes
      )
    end
  end
end
