class Group < ActiveRecord::Base

  has_many :role_assignments, :as => :entity

  validates_presence_of :name
  validates_uniqueness_of :name
  
end