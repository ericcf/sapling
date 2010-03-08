class SharedEmail < ActiveRecord::Base

  belongs_to :content, :polymorphic => true

  attr_accessor :comments

  validates_presence_of :recipient,
    :message => 'e-mail address required'
  validates_presence_of :content_id
  validates_presence_of :content_type
  validates_associated :content

  def title
    self.content.title
  end

  def parent
    self.content.parent
  end
end
