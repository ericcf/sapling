class WorkflowState < ActiveRecord::Base

  has_many :workflow_transitions,
    :foreign_key => :before_state_id,
    :dependent => :destroy
  has_many :workflow_transitions,
    :foreign_key => :after_state_id,
    :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.default
    find_or_create_by_name('private')
  end
end
