class Opportunity < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30

  belongs_to :source, :polymorphic => true
  belongs_to :opportunity_type
  belongs_to :opportunity_status
  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :notes, :as=>:parent

  validates :title, :presence => true
  validates :opportunity_type_id, :presence => true
  validates :opportunity_status_id, :presence => true
  validates :seats, :presence => true
  validates :experience, :presence => true
  validates :source_id, :presence => true
  validates :source_type, :presence => true
  validates :source_title, :presence => true
  
  def title_with_seat
    "#{title} (#{seats})"
  end

  def note_title
    title
  end

end
