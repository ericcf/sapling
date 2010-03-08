class CreateSlides < ActiveRecord::Migration
  def self.up
    create_table :slides do |t|
      # required common columns
      t.string :slug
      t.string :title

      t.text :text
      t.integer :target_id
      t.string :target_type
      t.integer :marquee_id

      t.timestamps
    end
  end

  def self.down
    drop_table :slides
  end
end
