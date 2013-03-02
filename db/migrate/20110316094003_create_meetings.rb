class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|

      t.date :date_of_meeting

      t.string :location
      t.text :attendees
      t.text :minutes_of_meeting

      t.time :start_time
      t.time :end_time

      t.references :meeting_type
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
