class PhoneType < ActiveRecord::Base
  has_many :phones

#  validates :phone_type, :presence => true

    def to_s
    self.phone_type
  end
end