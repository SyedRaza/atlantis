class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.text :additional_info
      t.integer :contact_status_id
      t.integer :contact_type_id
      t.integer :contact_directory_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
