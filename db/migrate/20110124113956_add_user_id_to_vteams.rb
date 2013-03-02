class AddUserIdToVteams < ActiveRecord::Migration
  def self.up
    add_column :vteams, :user_id, :integer
  end

  def self.down
    remove_column :vteams, :user_id
  end
end
