class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  attr_accessible :user_id, :role_id

  cattr_reader :auto_assign_user
  @@auto_assign_user = false
end
