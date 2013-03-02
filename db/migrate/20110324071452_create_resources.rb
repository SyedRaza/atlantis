class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.integer :employee_id
      t.string :name
      t.integer :number
      t.text :experience
      t.float :billing_rate
      t.integer :updated_by

      t.references :resource_type
      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
