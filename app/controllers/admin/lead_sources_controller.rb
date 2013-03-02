module Admin
  class LeadSourcesController < Admin::AdminController
    active_scaffold :lead_source do |config|
      config.columns = [:source]
    end
  end
end
