class CreateResourceBillingTypes < ActiveRecord::Migration
  def self.up
    create_table :resource_billing_types do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :resource_billing_types
  end
end
