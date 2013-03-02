class VacationType < ActiveRecord::Base
  has_many :vacations
  before_save :ensure_no_extra_space
  protected
  def ensure_no_extra_space
    self.title = self.title.capitalize.strip
  end
end
