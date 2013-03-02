class CreateDevCenters < ActiveRecord::Migration
  def self.up
    create_table :dev_centers do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :dev_centers
  end
end
