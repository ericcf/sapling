require 'content/base'

class Slide < ActiveRecord::Base

  include Content::Base

  belongs_to :marquee
  belongs_to :target, :polymorphic => true

  define_schema do |s|
    s.string            :title, :required => true, :display => 'header'
    s.text              :text
    s.content_reference :target, :label => 'Target ID'
  end
  
end
