class ResourceVteamAllocation < ActiveRecord::Base
  belongs_to :resource
  belongs_to :vteam
  belongs_to :resource_billing_type
  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :vacations

# validates_format_of :billing_rate, :with => /^[0-9]+(\.[0-9]{1,2})?$/
#  validates :resource, :presence => true
#  validates :vteam, :presence => true
#  validates :resource_role, :presence => true
#  validates :resource_billing_type, :presence => true
#  validates :billing_rate , :presence => true
#  validates :join_date , :presence => true
#  validates :active , :presence => true

  def title
    resource.title
  end
  def resource_type
    resource.resource_type.title
  end
end
