class MapPin < ActiveRecord::Base

  belongs_to :map, :class_name => 'GoogleMap'
  belongs_to :address
  
end
