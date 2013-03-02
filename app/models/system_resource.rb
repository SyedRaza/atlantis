class SystemResource < ActiveRecord::Base
  has_many :permissions, :dependent => :destroy 
  has_many :children, :class_name => "Resource", :foreign_key => "parent_resource"

  scope :root, lambda {
    {
      :conditions => "parent_resource IS NULL"
    }
  }

  accepts_nested_attributes_for :permissions
end
