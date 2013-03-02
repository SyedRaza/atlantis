class Country < ActiveRecord::Base
  has_many :addresses

  validates :name, :presence => true

  def to_s
    name
  end
end
