class WorkflowTrigger < ActiveRecord::Base

  belongs_to :content_workflow_state
  belongs_to :target_state, :class_name => 'WorkflowState'

  validates_presence_of :content_workflow_state
  validates_associated :content_workflow_state
  validates_presence_of :target_state
  validates_associated :target_state

  def transition_content
    unless content_workflow_state.workflow_state == target_state
      content_workflow_state.update_attributes(:workflow_state => target_state)
    end
    destroy
  end

  def activate_if_ready!
    raise "implement in subclass"
  end
end
