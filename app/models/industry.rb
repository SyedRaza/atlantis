class Industry < ActiveRecord::Base
  has_many :companies

  validates :title, :presence => true

  def to_s
    title
  end
end
