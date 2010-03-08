class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street
      t.string :line_two
      t.string :city
      t.string :state
      t.integer :zip_code
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
