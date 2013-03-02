class AddNoteToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :note, :string
  end

  def self.down
    remove_column :companies, :note
  end
end
