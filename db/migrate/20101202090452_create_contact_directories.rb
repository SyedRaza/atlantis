class CreateContactDirectories < ActiveRecord::Migration
  def self.up
    create_table :contact_directories do |t|
      t.string :directory_name

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_directories
  end
end
