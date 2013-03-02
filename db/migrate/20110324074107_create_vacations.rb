class CreateVacations < ActiveRecord::Migration
  def self.up
    create_table :vacations do |t|

      t.datetime :from
      t.datetime :to
      t.text :reason
      t.references :vacation_type
      t.references :resource_vteam_allocation
      t.timestamps
    end
  end

  def self.down
    drop_table :vacations
  end
end
