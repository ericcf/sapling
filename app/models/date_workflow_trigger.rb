class DateWorkflowTrigger < WorkflowTrigger

  def activate_if_ready!
    if activate_at < Time.now
      transition_content
    end
  end
end
