class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items do |t|
      # required common columns
      t.string :slug
      t.string :title

      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.text :text
      t.integer :author_id
      t.string :external_uri
      t.datetime :publish_date

      t.timestamps
    end
  end

  def self.down
    drop_table :news_items
  end
end
