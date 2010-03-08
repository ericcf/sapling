class CreateRoleAssignments < ActiveRecord::Migration
  def self.up
    create_table :role_assignments do |t|
      t.integer :role_id
      t.integer :entity_id
      t.string :entity_type
    end

    add_index :role_assignments, [:role_id, :entity_id, :entity_type], :unique => true
    add_index :role_assignments, [:entity_id, :entity_type]
  end

  def self.down
    drop_table :role_assignments
  end
end
