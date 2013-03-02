class RenameXDocGenerals < ActiveRecord::Migration
  def self.up
    rename_table :x_doc_generals, :note_generals
  end
  def self.down
    rename_table :note_generals, :x_doc_generals
  end
end
