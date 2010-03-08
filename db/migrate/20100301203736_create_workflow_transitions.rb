class CreateWorkflowTransitions < ActiveRecord::Migration
  def self.up
    create_table :workflow_transitions do |t|
			t.integer :before_state_id
			t.integer :after_state_id
			t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :workflow_transitions
  end
end
