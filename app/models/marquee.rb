require 'content/base'

class Marquee < ActiveRecord::Base

  include Content::Base

  has_many :slides, :dependent => :destroy

  after_update :save_slides

  define_schema do |s|
    s.string   :title, :required => true, :display => 'header'
    s.has_many :slides
  end

  define_page_sections do |page|
    page.view 'marquees/view'
  end

  def after_initialize
    if slides.empty?
      slides.build
    end
  end

  def new_slide_attributes=(slide_attributes)
    slide_attributes.each do |attributes|
      slides.build(attributes)
    end
  end

  def existing_slide_attributes=(slide_attributes)
    slides.reject(&:new_record?).each do |slide|
      attributes = slide_attributes[slide.id.to_s]
      if attributes
        slide.attributes = attributes
      else
        slides.delete(slide)
      end
    end
  end

  def save_slides
    slides.each do |slide|
      slide.save(false)
    end
  end
end
