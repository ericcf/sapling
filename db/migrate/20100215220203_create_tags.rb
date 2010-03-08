class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :label
      t.integer :parent_id
      t.integer :tag_collection_id

      t.timestamps
    end

    add_index :tags, :tag_collection_id
  end

  def self.down
    drop_table :tags
  end
end
