class LeadType < ActiveRecord::Base
  has_many :leads

  validates :lead_type, :presence => true

  def to_s
    self.lead_type
  end
end
