module Admin
  class ResourceBillingTypesController < Admin::AdminController
    active_scaffold :resource_billing_types do |config|
      config.columns = [:title]
    end
  end
end
