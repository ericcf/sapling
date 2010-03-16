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
      create_content_workflow_state(:workflow_state => state)
    end
  end

  def workflow_state
    content_workflow_state.workflow_state
  end

  def workflow_state=(new_state)
    content_workflow_state.update_attributes(:workflow_state => new_state)
  end

  def apply_workflow_triggers!
    content_workflow_state.apply_triggers!
  end
end
