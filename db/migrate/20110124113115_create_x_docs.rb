class CreateXDocs < ActiveRecord::Migration
  def self.up
    create_table :x_docs do |t|
      t.integer :user_id
      t.integer :x_doc_type_id
      t.references :detail, :polymorphic=>true
      t.references :parent, :polymorphic=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :x_docs
  end
end
