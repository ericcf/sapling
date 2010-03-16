class ContentWorkflowState < ActiveRecord::Base

  belongs_to :content, :polymorphic => true
  belongs_to :workflow_state
  has_many :workflow_triggers

  def apply_triggers!
    workflow_triggers.each do |t|
      t.activate_if_ready!
    end
  end
end
