class Website < ActiveRecord::Base
  belongs_to :website_type
  belongs_to :websiteable, :polymorphic => true

#  validates :url, :presence => true
#  validates :website_type_id, :presence => true
#  validates :websiteable_id, :presence => true
#  validates :websiteable_type, :presence => true

  def to_s
    "#{url} (#{website_type})"
  end
end
