module Admin
  class VacationTypesController < Admin::AdminController
    active_scaffold :vacation_types do |config|
      config.columns = [:title]
    end
  end
end
