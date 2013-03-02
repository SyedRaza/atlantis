class CreateResourceVteamAllocations < ActiveRecord::Migration
  def self.up
    create_table :resource_vteam_allocations do |t|


      t.datetime :join_date

      t.float :billing_rate
      t.boolean :active
      t.text :reason
      t.datetime :release_date

      t.integer :updated_by

      t.string :resource_type

      t.references :vteam
      t.references :resource
      t.references :resource_billing_type
      t.timestamps
    end
  end

  def self.down
    drop_table :resource_vteam_allocations
  end
end
