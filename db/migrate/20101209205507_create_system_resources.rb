class CreateSystemResources < ActiveRecord::Migration
  def self.up
    create_table :system_resources do |t|
      t.string :class_name
      t.string :class_action
      t.text :description
      t.integer :parent_resource
      
      t.timestamps
    end
  end

  def self.down
    drop_table :system_resources
  end
end
