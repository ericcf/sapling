class CreateWorkflowStates < ActiveRecord::Migration
  def self.up
    create_table :workflow_states do |t|
      t.string :name
      t.boolean :is_default
    end

    add_index :workflow_states, :name, :unique => true
  end

  def self.down
    drop_table :workflow_states
  end
end
