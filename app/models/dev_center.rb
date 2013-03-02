class DevCenter < ActiveRecord::Base
  has_many :vteams

  validates :name, :presence => true

  def to_s
    self.name
  end
end
