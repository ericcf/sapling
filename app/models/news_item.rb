class NewsItem < ActiveRecord::Base

  acts_like_content

  has_attached_file :image,
    :styles => { :thumb => ["128x128>", :jpg], :mini => ["64x64>", :jpg] }

  define_schema do |s|
    s.string :title, :label => 'Headline', :display => 'header'
    s.date   :publish_date, :label => 'Publish Date'
    s.image  :image, :label => 'Image'
    s.text   :text, :label => 'Text'
    s.uri    :external_uri, :label => 'Read the Article'
  end

  define_page_sections do |page|
    page.below_content 'news_items/below_content'
  end

  def image_delete=(value)
    if value.to_i == 1
      image.destroy
    end
  end
end
