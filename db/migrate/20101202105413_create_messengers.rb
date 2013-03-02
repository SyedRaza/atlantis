class CreateMessengers < ActiveRecord::Migration
  def self.up
    create_table :messengers do |t|
      t.string :title
      t.integer :messenger_service_id
      t.integer :messenger_type_id
      t.references :messengerable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :messengers
  end
end
