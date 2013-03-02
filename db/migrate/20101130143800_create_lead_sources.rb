class CreateLeadSources < ActiveRecord::Migration
  def self.up
    create_table :lead_sources do |t|
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :lead_sources
  end
end
