class AddNoteToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :note, :string
  end

  def self.down
    remove_column :contacts, :note
  end
end
