class CreateTagCollections < ActiveRecord::Migration
  def self.up
    create_table :tag_collections do |t|
      t.string :label
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_collections
  end
end
