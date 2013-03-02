module Admin
  class ContactDirectoriesController < Admin::AdminController
    active_scaffold :contact_directories do |config|
      config.columns = [:directory_name]
    end
  end
end

