class Resource < ActiveRecord::Base
  belongs_to :resource_type
  has_many :resource_vteam_allocation, :dependent => :destroy
  has_many :vteams, :through => :resource_vteam_allocation
  accepts_nested_attributes_for :resource_vteam_allocation, :allow_destroy => true

  def title
    "#{name}"
  end
  
  def descrpitive_title
    "#{name},#{resource_type.title},#{billing_rate}"
  end
end
