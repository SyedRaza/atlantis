class WebsiteType < ActiveRecord::Base
  has_many :websites

#  validates :website_type, :presence => true

    def to_s
    self.website_type
  end
end
