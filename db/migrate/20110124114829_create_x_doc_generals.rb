class CreateXDocGenerals < ActiveRecord::Migration
  def self.up
    create_table :x_doc_generals do |t|
      t.text :description
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.string :attachment_file_size

    end
  end

  def self.down
    drop_table :x_doc_generals
  end
end
