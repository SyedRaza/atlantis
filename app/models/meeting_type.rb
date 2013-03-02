class MeetingType < ActiveRecord::Base
  has_many :meetings

  def to_s
    self.meeting_type
  end
end
