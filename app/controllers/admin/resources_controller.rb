# To change this template, choose Tools | Templates
# and open the template in the editor.

module Admin
  class ResourcesController < Admin::AdminController
    active_scaffold :resources do |config|
      config.columns = [:name,:employee_id,:experience,:billing_rate,:resource_type]
      columns[:employee_id].label = "Employee ID"
    end
  end
end
