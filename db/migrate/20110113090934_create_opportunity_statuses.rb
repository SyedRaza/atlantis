class CreateOpportunityStatuses < ActiveRecord::Migration
  def self.up
    create_table :opportunity_statuses do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :opportunity_statuses
  end
end
