class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :email
      t.integer :email_type_id
      t.references :emailable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
