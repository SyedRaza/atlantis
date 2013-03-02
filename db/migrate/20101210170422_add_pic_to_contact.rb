class AddPicToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :pic_file_name, :string
    add_column :contacts, :pic_content_type, :string
    add_column :contacts, :pic_file_size, :integer
  end

  def self.down
    remove_column :contacts, :pic_file_size
    remove_column :contacts, :pic_content_type
    remove_column :contacts, :pic_file_name
  end
end
