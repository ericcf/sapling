require 'content/base'

class GoogleMap < ActiveRecord::Base

  include Content::Base

  has_many :map_pins
  has_many :addresses, :through => :map_pins

  define_schema do |s|
    s.string :title, :label => 'Title', :display => 'header'
    s.string :center_lat, :label => 'Center Latitude'
    s.string :center_lon, :label => 'Center Longitude'
    s.string :zoom_level, :label => 'Zoom Level'
    s.string :map_type, :label => 'Map Type'
  end
  
end
