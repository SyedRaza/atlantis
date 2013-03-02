class Vacation < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  belongs_to :resource_vteam_allocation
  belongs_to :vacation_type

  def resource
    self.resource_vteam_allocation.resource
  end
  
  def count_leaves(id, type = "")
    days = 0
    if type!= ""
      vt        = VacationType.find_by_title(type)
      vacations = Vacation.search({:vacation_type_id_eq             =>vt.id,
                                   :resource_vteam_allocation_id_eq => id})
    else
      vacations = Vacation.search(:resource_vteam_allocation_id_eq => id)
    end
    vacations.each do |v|
      days = days + v.from.business_days_until(v.to + 1)
    end
    days
  end

  def business_days_between(date1, date2)
    date1.business_days_until(date2+1)
  end

end
