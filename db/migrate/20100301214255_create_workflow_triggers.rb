class CreateWorkflowTriggers < ActiveRecord::Migration
  def self.up
    create_table :workflow_triggers do |t|
			t.string :type
      t.integer :content_workflow_state_id
			t.integer :workflow_transition_id

			t.datetime :activate_at

      t.timestamps
    end

		add_index :workflow_triggers, :content_workflow_state_id
		add_index :workflow_triggers, :workflow_transition_id
  end

  def self.down
    drop_table :workflow_triggers
  end
end
