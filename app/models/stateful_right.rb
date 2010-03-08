class StatefulRight < ActiveRecord::Base

  belongs_to :right
  belongs_to :workflow_state
  belongs_to :role

  validates_uniqueness_of :right_id,
    :scope => [:workflow_state_id, :role_id]
  
end