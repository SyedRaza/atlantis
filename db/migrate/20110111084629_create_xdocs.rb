class CreateXdocs < ActiveRecord::Migration
  def self.up
    create_table :xdocs do |t|
      t.string :title
      t.integer :xdoc_type_id
      t.text :detail

      t.timestamps
    end
  end

  def self.down
    drop_table :xdocs
  end
end
