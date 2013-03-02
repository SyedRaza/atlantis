class MessengerType < ActiveRecord::Base
  has_many :messengers

#  validates :messenger_type, :presence => true

    def to_s
    self.messenger_type
  end
end
