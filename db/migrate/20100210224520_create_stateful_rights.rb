class CreateStatefulRights < ActiveRecord::Migration
  def self.up
    create_table :stateful_rights do |t|
      t.integer :right_id
      t.integer :role_id
      t.integer :workflow_state_id
    end

    add_index :stateful_rights, [:right_id, :role_id, :workflow_state_id], :unique => true
  end

  def self.down
    drop_table :stateful_rights
  end
end
