class AddUpdatedByToAllTables < ActiveRecord::Migration
  def self.up
    add_column :leads, :updated_by, :integer
    add_column :opportunities, :updated_by, :integer
    add_column :vteams, :updated_by, :integer
    add_column :placements, :updated_by, :integer
    add_column :meetings, :updated_by, :integer
    add_column :companies, :updated_by, :integer
    add_column :contacts, :updated_by, :integer
    add_column :notes, :updated_by, :integer
  end

  def self.down
    remove_column :leads, :updated_by
    remove_column :opportunities, :updated_by
    remove_column :vteams, :updated_by
    remove_column :placements, :updated_by
    remove_column :meetings, :updated_by
    remove_column :companies, :updated_by
    remove_column :contacts, :updated_by
    remove_column :notes, :updated_by
  end
end
