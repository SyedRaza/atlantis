class CreateMeetingTypes < ActiveRecord::Migration
  def self.up
    create_table :meeting_types do |t|
      t.string :meeting_type
      
    end
  end

  def self.down
    drop_table :meeting_types
  end
end
