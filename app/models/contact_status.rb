class ContactStatus < ActiveRecord::Base
  has_many :contacts

  validates :status, :presence => true

  def to_s
    status
  end
end
