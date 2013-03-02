class Meeting < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30
  belongs_to :meeting_type
  belongs_to :user
  has_many :notes, :as => :parent
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"

  validates :date_of_meeting, :presence => true
  validates :start_time, :presence => true
  validates :end_time, :presence => true
  validates :location, :presence => true
  validates :attendees, :presence => true
  validates :minutes_of_meeting, :presence => true
  validates :meeting_type_id, :presence => true
  validates :user_id, :presence => true


  def title
    "Meeting on #{date_of_meeting}"
  end

  def note_title
    "Meeting on #{date_of_meeting}"
  end

  def meeting_start_time
    "#{start_time.hour}:#{start_time.min}"

  end

  def meeting_time_str
    seconds = self.meeting_time
    min, sec = seconds.divmod(60)
    hour, min = min.divmod(60)
    "#{hour.to_s.rjust(2, '0')}:#{min.to_s.rjust(2, '0')}"
  end

  def meeting_time
    end_time - start_time
  end

  def total_attendees_meeting_time
    (end_time - start_time) * attendees.to_s.split(",").count
  end

  def number_of_attendees
    attendees.to_s.split(',').count
  end

end
