class WorkflowTransition < ActiveRecord::Base

	belongs_to :before_state, :class_name => 'WorkflowState'
	belongs_to :after_state, :class_name => 'WorkflowState'

	validates_presence_of :name
	validates_associated :before_state
	validates_associated :after_state

end
