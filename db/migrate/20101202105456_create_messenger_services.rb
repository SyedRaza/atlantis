class CreateMessengerServices < ActiveRecord::Migration
  def self.up
    create_table :messenger_services do |t|
      t.string :service

      t.timestamps
    end
  end

  def self.down
    drop_table :messenger_services
  end
end
