module Admin
  class LeadTypesController < Admin::AdminController
    active_scaffold :lead_type do |config|
      config.columns = [:lead_type]
    end
  end
end
