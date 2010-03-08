class CreateChunks < ActiveRecord::Migration
  def self.up
    create_table :chunks do |t|
      t.string :name
      t.text :text
      t.integer :section_id
      t.integer :section_index

      t.timestamps
    end
  end

  def self.down
    drop_table :chunks
  end
end
