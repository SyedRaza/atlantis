class Company < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30

  belongs_to :industry
  belongs_to :user
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :leads, :dependent => :destroy
  has_many :contact_company_profiles
  has_many :contacts, :through => :contact_company_profiles
  has_many :phones, :as => :phoneable, :dependent => :destroy
  has_many :websites, :as => :websiteable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :addresses, :as => :addressable, :dependent => :destroy
  has_many :notes, :as=>:parent

  accepts_nested_attributes_for :phones, :reject_if => proc { |a| a['phone_number'].blank? }
  accepts_nested_attributes_for :websites, :reject_if => proc { |a| a['url'].blank? }
  accepts_nested_attributes_for :emails, :reject_if => proc { |a| a['email'].blank? }
  accepts_nested_attributes_for :addresses, :reject_if => proc { |a| a['street'].blank? || a['country_id'].blank? }

  validates :title, :presence => true

  def to_s
    "#{title}"
  end

  def note_title
    self.title
  end

  scope :with_phones,
    lambda { |number|
    joins(:phones).where(:phone_number => number)
  }


end