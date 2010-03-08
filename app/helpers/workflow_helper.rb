module WorkflowHelper

  def workflow_state_list
    WorkflowState.all.map { |state| state.name }
  end
end