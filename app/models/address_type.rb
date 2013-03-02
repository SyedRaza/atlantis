class AddressType < ActiveRecord::Base
  has_many :addresses

  validates :address_type, :presence => true

  def to_s
    address_type
  end
end
