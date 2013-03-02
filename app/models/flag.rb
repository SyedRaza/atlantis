class Flag < ActiveRecord::Base
  has_many :vteams

  validates :name, :presence => true

end
