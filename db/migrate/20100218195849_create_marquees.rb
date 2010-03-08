class CreateMarquees < ActiveRecord::Migration
  def self.up
    create_table :marquees do |t|
      # required common columns
      t.string :slug
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :marquees
  end
end
