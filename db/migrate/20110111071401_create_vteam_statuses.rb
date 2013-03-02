class CreateVteamStatuses < ActiveRecord::Migration
  def self.up
    create_table :vteam_statuses do |t|
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :vteam_statuses
  end
end
