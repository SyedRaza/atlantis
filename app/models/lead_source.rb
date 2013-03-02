class LeadSource < ActiveRecord::Base
  has_many :leads

  validates :source, :presence => true

  def to_s
    self.source
  end
end
