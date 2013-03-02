class Placement < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :user
  has_many :notes, :as=>:parent
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"

  validates :date_effective, :presence => true
  validates :available_resources, :presence => true
  validates :freeing_up_resources, :presence => true
  validates :reserved_resources, :presence => true
  validates :summary, :presence => true

  def title
    "Placement on #{date_effective}"
  end

  def note_title
    "Placement on #{date_effective}"
  end
end
