class TagAssociation < ActiveRecord::Base

  belongs_to :tag
  belongs_to :content,
    :polymorphic => true

  validates_presence_of :tag
  validates_associated :tag
  validates_presence_of :content
  validates_associated :content
  
end
