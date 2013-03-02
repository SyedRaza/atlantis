class CreateAttachedDocumentsDefaultTypes < ActiveRecord::Migration

  def self.up
    create_table :attached_documents_default_types do |t|
      t.string :title
      t.integer :parent_id
    end
  end

  def self.down
    drop_table :attached_documents_default_types
  end

end