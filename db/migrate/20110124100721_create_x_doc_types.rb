class CreateXDocTypes < ActiveRecord::Migration
  def self.up
    create_table :x_doc_types do |t|
      t.integer :user_id
      t.string :title
      t.string :class_name
      t.integer :position
      t.string :ancestry
      
    end
  end

  def self.down
    drop_table :x_doc_types
  end
end
