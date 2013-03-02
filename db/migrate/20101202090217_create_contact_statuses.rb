class CreateContactStatuses < ActiveRecord::Migration
  def self.up
    create_table :contact_statuses do |t|
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_statuses
  end
end
