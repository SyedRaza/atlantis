module Admin
  class MessengerTypesController < Admin::AdminController
    active_scaffold :messenger_type do |config|
      config.columns = [:messenger_type]
    end
  end
end
