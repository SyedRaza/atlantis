class CreateVteams < ActiveRecord::Migration
  def self.up
    create_table :vteams do |t|
      t.string :name
      t.integer :vteam_status_id
      t.date :start_date
      t.integer :lead_id
      t.string :dev_manager
      t.string :working_hours
      t.integer :dev_center_id
      t.integer :billing_mode_id
      t.date :approved_on
      t.integer :flag_id
      t.text :developers
      t.text :intent_to_start
      t.text :startup_advice
      t.text :technologies
      t.text :special_note
      t.text :key_dates
      t.boolean :updated_by_client

      t.timestamps
    end
  end

  def self.down
    drop_table :vteams
  end
end
