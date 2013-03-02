module Admin
  class OpportunityTypesController < Admin::AdminController
    active_scaffold :opportunity_type do |config|
      config.columns = [:name]
    end
  end
end
