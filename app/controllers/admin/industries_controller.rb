module Admin
  class IndustriesController < Admin::AdminController
    active_scaffold :industry do |config|
      config.columns = [:title]
    end
  end
end