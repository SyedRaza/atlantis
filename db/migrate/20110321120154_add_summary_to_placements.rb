class AddSummaryToPlacements < ActiveRecord::Migration
  def self.up
    add_column :placements, :summary, :text
  end

  def self.down
    remove_column :placements, :summary
  end
end
