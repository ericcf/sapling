class CreateSharedEmails < ActiveRecord::Migration
  def self.up
    create_table :shared_emails do |t|
      t.string :recipient
      t.string :sender
      t.integer :content_id
      t.string :content_type

      t.timestamps
    end
  end

  def self.down
    drop_table :shared_emails
  end
end
