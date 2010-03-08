class Right < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :controller
  validates_presence_of :action
  validates_uniqueness_of :action, :scope => :controller

end
