class RenameXdocs < ActiveRecord::Migration
  def self.up
    rename_table :x_docs, :notes
  end
  def self.down
    rename_table :notes, :x_docs
  end

end
