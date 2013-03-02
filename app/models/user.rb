class User < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 30
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles

  has_many :leads
  has_many :opportunities
  has_many :vteams
  has_many :contacts
  has_many :companies
  has_many :placements
  has_many :meetings
  has_many :note_types

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :name, :password, :password_confirmation, :remember_me, :time_zone, :user_roles_attributes
  accepts_nested_attributes_for :user_roles

  validates :email, :uniqueness => true

  # Check weither the user is in the specific role
  def role?(role)
    self.roles.each do |r|
      return true if r.name == role.to_s
    end
    false
  end

  def to_s
    name
  end
end
