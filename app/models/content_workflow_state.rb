class ContentWorkflowState < ActiveRecord::Base

	belongs_to :content, :polymorphic => true
	belongs_to :workflow_state
	has_many :workflow_triggers

end
