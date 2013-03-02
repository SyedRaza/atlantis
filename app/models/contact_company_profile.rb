class ContactCompanyProfile < ActiveRecord::Base
  belongs_to :contact
  belongs_to :company

#  validates :contact_id, :presence => true
#  validates :company_id, :presence => true

end
