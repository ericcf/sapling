class Slide < ActiveRecord::Base

  acts_like_content

  belongs_to :marquee
  belongs_to :target, :polymorphic => true

  define_schema do |s|
    s.string            :title, :required => true, :display => 'header'
    s.text              :text
    s.content_reference :target, :label => 'Target ID'
  end
  
end
