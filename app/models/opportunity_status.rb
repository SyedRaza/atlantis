class OpportunityStatus < ActiveRecord::Base
  has_many :opportunities
  validates :name, :presence => true

  def to_s
    self.name
  end
end
