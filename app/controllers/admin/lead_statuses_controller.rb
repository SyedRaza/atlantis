module Admin
  class LeadStatusesController < Admin::AdminController
    active_scaffold :lead_status do |config|
      config.columns = [:status]
    end
  end
end
