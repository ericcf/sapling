class CreateGoogleMaps < ActiveRecord::Migration
  def self.up
    create_table :google_maps do |t|
      # required common columns
      t.string :slug
      t.string :title
      
      t.float :center_lat
      t.float :center_lon
      t.integer :zoom_level
      t.string :map_type

      t.timestamps
    end
  end

  def self.down
    drop_table :google_maps
  end
end
