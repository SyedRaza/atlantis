module Admin
  class AddUsersController < Admin::AdminController
    active_scaffold :user do |config|
      config.columns = [:email]
    end
  end
end