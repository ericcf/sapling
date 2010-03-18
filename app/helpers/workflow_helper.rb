module WorkflowHelper

  def workflow_states
    WorkflowState.all.map &:name
  end
end