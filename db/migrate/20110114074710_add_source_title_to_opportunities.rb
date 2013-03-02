class AddSourceTitleToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :source_title, :string
  end

  def self.down
    remove_column :opportunities, :source_title
  end
end
