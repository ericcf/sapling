class CreateContentWorkflowStates < ActiveRecord::Migration
  def self.up
    create_table :content_workflow_states do |t|
			t.string :content_type
			t.integer :content_id
			t.integer :workflow_state_id

      t.timestamps
    end
  end

  def self.down
    drop_table :content_workflow_states
  end
end
