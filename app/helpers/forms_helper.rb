module FormsHelper

  class ActionView::Helpers::FormBuilder

    def rich_text_area(method, options)
      @template.render(:partial => 'shared/fields/edit/rich_text_area',
         :locals => { :form => self, :field_name => method })
    end

    def date_select_field(method, options)
      @template.render(:partial => 'shared/fields/edit/date_select',
         :locals => { :form => self, :field_name => method })
    end

    def image_upload_field(method, options)
      @template.render(:partial => 'shared/fields/edit/image_upload',
         :locals => { :form => self, :field_name => method })
    end

    def content_reference_field(method, options)
      @template.render(:partial => 'shared/fields/edit/content_reference',
         :locals => { :form => self, :field_name => method })
    end

    def has_many_field(method, options)
      @template.render(:partial => 'shared/fields/edit/has_many',
         :locals => { :form => self, :field_name => method, :schema_field => options[:schema_field] })
    end
  end

  class SaplingFormBuilder < ActionView::Helpers::FormBuilder

    def self.create_decorated_field(method_name)
      define_method(method_name) do |method, *args|
        options = args.first || {}
        if options[:decorated] == false
          return super
        end
				schema_field = options[:schema_field]
				label = schema_field ? schema_field.label : method.to_s.humanize
				required = schema_field ? schema_field.required : options[:required]
        @template.render(:partial => 'shared/fields/edit/field',
          :locals => { :form => self, :field => super, :schema_field => schema_field, :field_name => method.to_s, :label => label, :required => required })
      end
    end

    def self.field_helpers
      super + [:rich_text_area,
				:date_select_field,
				:image_upload_field,
				:content_reference_field,
				:has_many_field
			]
    end

    field_helpers.each do |name|
      unless ['hidden_field', 'label'].include?(name.to_s)
        create_decorated_field(name)
      end
    end
  end

  ActionView::Base.default_form_builder = SaplingFormBuilder

  def add_content_link(name, selector, klass)
    link_to_function name, "jQuery('#{selector}').append('#{escape_javascript render(:partial => 'shared/fields/edit/sub_content', :object => klass.new)}')"
  end
end
