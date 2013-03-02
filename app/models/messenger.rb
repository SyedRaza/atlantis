class Messenger < ActiveRecord::Base
  belongs_to :messenger_service
  belongs_to :messengerable, :polymorphic  => true
  belongs_to :messenger_type

#  validates :title, :presence => true
#  validates :messenger_service_id, :presence => true
#  validates :messenger_type_id, :presence => true
#  validates :messengerable_id, :presence => true
#  validates :messengerable_type, :presence => true


  def to_s
    "#{title} (#{messenger_type} - #{messenger_service})"
  end
end
