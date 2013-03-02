class VteamStatus < ActiveRecord::Base
  has_many :vteams

  validates :status, :presence => true

  def to_s
    self.status
  end

end
