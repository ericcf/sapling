class WorkflowTrigger < ActiveRecord::Base

	belongs_to :content_workflow_state
	belongs_to :workflow_transition

	validates_presence_of :content_workflow_state
	validates_associated :content_workflow_state
	validates_presence_of :workflow_transition
	validates_associated :workflow_transition

	def transition_content
		target_state = workflow_transition.after_state
		unless content_workflow_state.workflow_state == target_state
			content_workflow_state.update_attributes(:workflow_state => target_state)
		end
	end

end
