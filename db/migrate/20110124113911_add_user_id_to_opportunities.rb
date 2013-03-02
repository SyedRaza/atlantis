class AddUserIdToOpportunities < ActiveRecord::Migration
  def self.up
    add_column :opportunities, :user_id, :integer
  end

  def self.down
    remove_column :opportunities, :user_id
  end
end
