module Admin
  class ContactTypesController < Admin::AdminController
    active_scaffold :contact_type do |config|
      config.columns = [:contact_type]
    end
  end
end
