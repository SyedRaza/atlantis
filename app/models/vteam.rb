class Vteam < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30

  belongs_to :lead
  belongs_to :vteam_status
  belongs_to :flag
  belongs_to :dev_center
  belongs_to :billing_mode
  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :opportunities, :as => :source
  has_many :notes, :as=>:parent
  has_many :resource_vteam_allocations, :dependent => :destroy
  has_many :resources, :through => :resource_vteam_allocations

  validates :name, :presence => true
  validates :vteam_status_id, :presence => true
  validates :lead_id, :presence => true
  validates :dev_manager, :presence => true
  validates :dev_center_id, :presence => true
  validates :billing_mode_id, :presence => true
  validates :working_hours, :presence => true
  validates :approved_on, :presence => true

  def title
    name
  end
  
  def note_title
    name
  end

end
