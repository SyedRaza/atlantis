class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|
      t.boolean :can_read
      t.boolean :can_create
      t.boolean :can_edit
      t.boolean :can_delete
      t.integer :role_id
      t.integer :resource_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :permissions
  end
end
