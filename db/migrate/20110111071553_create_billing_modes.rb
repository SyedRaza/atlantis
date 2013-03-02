class CreateBillingModes < ActiveRecord::Migration
  def self.up
    create_table :billing_modes do |t|
      t.string :mode

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_modes
  end
end
