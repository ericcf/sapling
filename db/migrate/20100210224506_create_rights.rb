class CreateRights < ActiveRecord::Migration
  def self.up
    create_table :rights do |t|
      t.string :name
      t.string :controller
      t.string :action
    end
  end

  def self.down
    drop_table :rights
  end
end
