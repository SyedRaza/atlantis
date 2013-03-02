class CreateAttachedDocuments < ActiveRecord::Migration

  def self.up
    create_table :attached_documents do |t|

      # paper clip Attachment fields
      t.string  :attachment_file_name
      t.string  :attachment_content_type
      t.string  :attachment_file_size

      # Object fields 
      t.text    :description
      t.text    :title

      t.references :typeable, :polymorphic=>true
      t.references :attachable, :polymorphic=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :attached_documents
  end

end