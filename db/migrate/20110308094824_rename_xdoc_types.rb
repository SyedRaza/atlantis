class RenameXdocTypes < ActiveRecord::Migration
  def self.up
    rename_table :x_doc_types, :note_types
  end
  def self.down
    rename_table :note_types, :x_doc_types
  end
end
