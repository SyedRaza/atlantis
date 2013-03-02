class CreateResourceRoles < ActiveRecord::Migration
  def self.up
    create_table :resource_roles do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_roles
  end
end
