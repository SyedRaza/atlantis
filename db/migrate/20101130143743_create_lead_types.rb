class CreateLeadTypes < ActiveRecord::Migration
  def self.up
    create_table :lead_types do |t|
      t.string :lead_type

      t.timestamps
    end
  end

  def self.down
    drop_table :lead_types
  end
end
