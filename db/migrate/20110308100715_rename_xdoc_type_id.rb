class RenameXdocTypeId < ActiveRecord::Migration
  def self.up
    rename_column :notes, :x_doc_type_id, :note_type_id
  end

  def self.down
    rename_column :notes, :note_type_id, :x_doc_type_id
  end

end
