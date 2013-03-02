module Admin
  class MessengerServicesController < Admin::AdminController
    active_scaffold :messenger_service do |config|
      config.columns = [:service]
    end
  end
end
