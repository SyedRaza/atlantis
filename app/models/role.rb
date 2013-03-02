class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, :through => :user_roles
  has_many :permissions

  def to_s
    self.name
  end
end
