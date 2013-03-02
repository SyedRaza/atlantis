module Admin
  class EmailTypesController < Admin::AdminController
    active_scaffold :email_type do |config|
      config.columns = [:service]
    end
  end
end