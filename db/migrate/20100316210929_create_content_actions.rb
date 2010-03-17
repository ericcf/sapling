class CreateContentActions < ActiveRecord::Migration
  def self.up
    create_table :content_actions do |t|
      t.string :content_type
      t.integer :content_id
      t.integer :user_id
      t.string :action

      t.timestamps
    end

    add_index :content_actions, [:content_type, :content_id]
    add_index :content_actions, :user_id
  end

  def self.down
    drop_table :content_actions
  end
end
