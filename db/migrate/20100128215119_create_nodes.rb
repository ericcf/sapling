class CreateNodes < ActiveRecord::Migration
  def self.up
    create_table :nodes do |t|
      t.text :path
      t.integer :parent_id
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end

    add_index :nodes, :path, :unique => true
    add_index :nodes, :parent_id
    add_index :nodes, [:content_id, :content_type], :unique => true
  end

  def self.down
    drop_table :nodes
  end
end
