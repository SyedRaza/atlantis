class Email < ActiveRecord::Base
  belongs_to :email_type
  belongs_to :emailable, :polymorphic => true

#  validates :email, :presence => true
#  validates :email_type_id, :presence => true
#  validates :emailable_id, :presence => true
#  validates :emailable_type, :presence => true


  def to_s
    "#{email}"
  end

end
