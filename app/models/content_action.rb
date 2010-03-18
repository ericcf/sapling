class ContentAction < ActiveRecord::Base

  belongs_to :user
  belongs_to :content, :polymorphic => true

  validates_presence_of :content
  validates_associated :content
  validates_presence_of :user
  validates_associated :user

  CREATED = 'created'
  MODIFIED = 'modified'
  
end
