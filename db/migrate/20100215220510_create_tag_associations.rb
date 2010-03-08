class CreateTagAssociations < ActiveRecord::Migration
  def self.up
    create_table :tag_associations do |t|
      t.integer :tag_id
      t.string :content_type
      t.integer :content_id

      t.timestamps
    end

    add_index :tag_associations, :tag_id
    add_index :tag_associations, [:content_type, :content_id]
  end

  def self.down
    drop_table :tag_associations
  end
end
