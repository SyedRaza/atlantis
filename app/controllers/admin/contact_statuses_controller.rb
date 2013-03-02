module Admin
  class ContactStatusesController < Admin::AdminController
    active_scaffold :contact_status do |config|
      config.columns = [:status]
    end
  end
end
