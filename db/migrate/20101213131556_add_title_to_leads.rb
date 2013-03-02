class AddTitleToLeads < ActiveRecord::Migration
  def self.up
    add_column :leads, :title, :string
  end

  def self.down
    remove_column :leads, :title
  end
end
