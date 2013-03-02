module Admin
  class WebsiteTypesController < Admin::AdminController
    active_scaffold :website_type do |config|
      config.columns = [:website_type]
    end
  end
end
