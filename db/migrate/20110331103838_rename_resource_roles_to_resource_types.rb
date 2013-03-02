class RenameResourceRolesToResourceTypes < ActiveRecord::Migration
  def self.up
    rename_table :resource_roles, :resource_types
  end

  def self.down
    rename_table :resource_types, :resource_roles
  end
end
