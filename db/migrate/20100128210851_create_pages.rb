class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      # required common columns
      t.string :slug
      t.string :title

      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
