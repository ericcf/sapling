class WorkflowTransition < ActiveRecord::Base

  belongs_to :before_state, :class_name => 'WorkflowState'
  belongs_to :after_state, :class_name => 'WorkflowState'
  has_many :workflow_triggers, :dependent => :destroy

  validates_presence_of :name
  validates_presence_of :before_state
  validates_associated :before_state
  validates_presence_of :after_state
  validates_associated :after_state

end
