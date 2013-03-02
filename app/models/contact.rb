class Contact < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30

  belongs_to :user
  belongs_to :contact_directory
  belongs_to :contact_status
  belongs_to :contact_type
  belongs_to :updated_by, :foreign_key => "updated_by", :class_name => "User"
  has_many :phones, :as => :phoneable, :dependent => :destroy
  has_many :websites, :as => :websiteable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :messengers, :as => :messengerable, :dependent => :destroy
  has_many :addresses, :as => :addressable, :dependent => :destroy
  has_many :leads, :dependent => :destroy
  has_many :contact_company_profiles, :dependent => :destroy
  has_many :companies, :through => :contact_company_profiles
  has_many :notes, :as=>:parent

  accepts_nested_attributes_for :contact_company_profiles, :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => proc { |a| a['phone_number'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :websites, :reject_if => proc { |a| a['url'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :emails, :reject_if => proc { |a| a['email'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :messengers, :reject_if => proc { |a| a['title'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :reject_if => proc { |a| a['street'].blank? || a['country_id'].blank? || a['address_type_id'].blank? }, :allow_destroy => true

  has_attached_file :pic, :styles => {:medium => "150x180", :thumb => "50x60"}, :default_url => "/system/:attachment/missing_:style.jpg"
  validates_attachment_size :pic, :less_than => 1.megabytes
  validates_attachment_content_type :pic, :content_type=>['image/jpeg', 'image/png', 'image/gif']

  validates :first_name, :presence => true
  validates :last_name, :presence => true


  def abc
    true
  end

  def def
    true
  end

  def current_company
    if self.companies.length == 0
      "-"
    else
      cp =self.contact_company_profiles.where("active = ?", 1)
      if cp.length != 0
        cp[0].company
      elsif cp.length == 0
        #self.companies.first
        "-"
      end
    end
  end

  def to_s
    "#{first_name}"
  end

  def complete_name
    "#{first_name} #{last_name}"
  end

  def title
    "#{first_name} #{last_name}"
  end

  def note_title
    self.first_name + " " +self.last_name
  end

end