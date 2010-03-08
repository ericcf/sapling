module Content

  module View

    def self.included(base)
      base.class_eval do
        class << self; attr_reader :page end
        @page = Page.new
      end
      base.extend(ClassMethods)
    end

    module ClassMethods

      def define_page_sections
        yield(@page) if block_given?
      end
    end

    def page_sections
      self.class.page.sections
    end
  end
end
