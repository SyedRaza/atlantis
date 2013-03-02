class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :phone_number
      t.integer :phone_type_id
      t.references :phoneable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
