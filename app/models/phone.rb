class Phone < ActiveRecord::Base

  belongs_to :phone_type
  belongs_to :phoneable, :polymorphic => true

  #validates :phone_number, :presence => true
  #validates :phone_type_id, :presence => true
  #validates :phoneable_id, :presence => true
  #validates :phoneable_type, :presence => true

  def to_s
    "#{phone_number}"
  end
end
