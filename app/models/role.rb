class Role < ActiveRecord::Base

  has_many :stateful_rights

  validates_presence_of :name
  validates_uniqueness_of :name

  def rights(state_name)
    # this intentionally allows for a nil state,
    # which is the case for "stateless" content
    state = WorkflowState.find_by_name(state_name)
    state_id = state.nil? ? nil : state.id
    stateful_rights.find_all_by_workflow_state_id(state_id).
      map { |sr| sr.right }
  end

end