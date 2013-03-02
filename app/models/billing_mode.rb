class BillingMode < ActiveRecord::Base
  has_many :vteams

  validates :mode, :presence => true

  def to_s
    self.mode
  end
end
