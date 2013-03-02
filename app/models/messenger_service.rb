class MessengerService < ActiveRecord::Base

  has_many :messengers

#  validates :service, :presence => true

    def to_s
    self.service
  end
end
