class EmailType < ActiveRecord::Base
  has_many :emails

#  validates :service, :presence => true

  def to_s
    service
  end
end
