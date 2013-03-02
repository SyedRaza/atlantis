class Lead < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30

  belongs_to :lead_status
  belongs_to :lead_type
  belongs_to :lead_source
  belongs_to :contact
  belongs_to :company
  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :vteams
  has_many :opportunities, :as => :source
  has_many :notes, :as=>:parent

  accepts_nested_attributes_for :contact
  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :opportunities

  validates :lead_status_id, :presence => true
  validates :lead_source_id, :presence => true
  validates :lead_type_id, :presence => true

  def title
    self.contact.first_name + " " +self.contact.last_name
  end

  def note_title
    self.contact.first_name + " " +self.contact.last_name
  end

  scope :status_title,
        lambda { |title|
          joins(:lead_status).where(:lead_statuses => {:status => title})
        }

  search_methods :status_title
end
