class CreateMessengerTypes < ActiveRecord::Migration
  def self.up
    create_table :messenger_types do |t|
      t.string :messenger_type

      t.timestamps
    end
  end

  def self.down
    drop_table :messenger_types
  end
end
