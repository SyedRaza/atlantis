class ContactDirectory < ActiveRecord::Base
  has_many :contacts

  validates :directory_name, :presence => true

  def to_s
    directory_name
  end
end
