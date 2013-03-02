class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.integer :country_id
      t.integer :address_type_id
      t.float :lat, :precision=>10, :scale=>6
      t.float :lng, :precision=>10, :scale=>6
      t.references :addressable, :polymorphic => true
     
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
