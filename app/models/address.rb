class Address < ActiveRecord::Base
  belongs_to :address_type
  belongs_to :addressable, :polymorphic => true
  belongs_to :country

  
  validates_associated :country
  validates_associated :address_type
#  validates :addressable_id, :presence => true
#  validates :addressable_type, :presence => true

  def to_s
    "#{street} #{city}, #{state} #{zip}, #{country}"
  end
end
