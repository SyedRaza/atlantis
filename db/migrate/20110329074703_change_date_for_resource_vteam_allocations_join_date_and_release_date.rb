class ChangeDateForResourceVteamAllocationsJoinDateAndReleaseDate < ActiveRecord::Migration
  def self.up
    change_table :resource_vteam_allocations do |t|
    t.change :join_date, :date
    t.change :release_date, :date
    end
  end

  def self.down
    change_table :resource_vteam_allocations do |t|
    t.change :join_date, :datetime
    t.change :release_date, :datetime
    end
  end
end
