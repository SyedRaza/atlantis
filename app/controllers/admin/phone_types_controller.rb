module Admin
  class PhoneTypesController < Admin::AdminController
    active_scaffold :phone_type do |config|
      config.columns = [:phone_type]
    end
  end
end
