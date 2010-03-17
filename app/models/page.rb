class Page < ActiveRecord::Base

  acts_like_content

  define_schema do |s|
    s.string :title, :label => 'Title', :required => true, :display => 'header'
    s.text   :text, :label => 'Text'
  end

  define_page_sections do |page|
    page.below_content 'shared/content/list_children'
  end
end
