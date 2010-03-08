module Stateful

  def self.included(base)
    base.class_eval do
      has_one :content_workflow_state, :as => :content

      after_create :set_workflow_state
    end
  end

  def set_workflow_state
    state = WorkflowState.default
    
    if state
      self.content_workflow_state =
        ContentWorkflowState.create(:content => self, :workflow_state => state)
    end
  end

  def workflow_state
    content_workflow_state.workflow_state
  end

  def workflow_state=(new_state)
    content_workflow_state.update_attributes(:workflow_state => new_state)
  end
end
