class WorkflowState < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

	def self.default
	  find_or_create_by_name('private')
	end
  
end
