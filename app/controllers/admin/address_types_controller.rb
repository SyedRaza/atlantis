module Admin
  class AddressTypesController < Admin::AdminController
    active_scaffold :address_type do |config|
      config.columns = [:address_type]
    end
  end
end