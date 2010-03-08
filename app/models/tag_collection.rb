class TagCollection < ActiveRecord::Base

  has_many :tags, :dependent => :destroy

  validates_presence_of :label

  after_update :save_tags

  def top_level_tags
    tags.reject &:parent
  end
  
  def new_tag_attributes=(tag_attributes)
    tag_attributes.each do |attributes|
      tags.build(attributes)
    end
  end

  def existing_tag_attributes=(tag_attributes)
    tags.reject(&:new_record?).each do |tag|
      attributes = tag_attributes[tag.id.to_s]
      if attributes
        tag.attributes = attributes
      else
        tags.delete(tag)
      end
    end
  end

  private

  def save_tags
    tags.each do |tag|
      tag.save(false)
    end
  end
end
