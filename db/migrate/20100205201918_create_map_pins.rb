class CreateMapPins < ActiveRecord::Migration
  def self.up
    create_table :map_pins do |t|
      t.integer :map_id
      t.integer :address_id

      t.timestamps
    end
  end

  def self.down
    drop_table :map_pins
  end
end
