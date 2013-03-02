class ContactType < ActiveRecord::Base
  has_many :contacts

  validates :contact_type, :presence => true

  def to_s
    contact_type
  end
end
