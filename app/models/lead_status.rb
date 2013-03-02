class LeadStatus < ActiveRecord::Base

  has_many :leads

  validates :status, :presence => true

  def to_s
    self.status
  end
end
