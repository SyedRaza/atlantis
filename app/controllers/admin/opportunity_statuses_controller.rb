module Admin
  class OpportunityStatusesController < Admin::AdminController
    active_scaffold :opportunity_status do |config|
      config.columns = [:name]
    end
  end
end
