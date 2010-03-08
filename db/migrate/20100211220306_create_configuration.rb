class CreateConfiguration < ActiveRecord::Migration
  def self.up
    create_table :configuration do |t|
      t.string :classname
      t.text :object
    end
  end

  def self.down
    drop_table :configuration
  end
end
