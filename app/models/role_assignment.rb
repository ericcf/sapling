class RoleAssignment < ActiveRecord::Base

  belongs_to :role
  belongs_to :entity, :polymorphic => true

  validates_uniqueness_of :role_id, :scope => [:entity_id, :entity_type]
  
end