module Admin
  class ResourceTypesController < Admin::AdminController
    active_scaffold :resource_type do |config|
      config.columns = [:title]
    end
  end
end
