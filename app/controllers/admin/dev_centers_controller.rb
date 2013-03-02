module Admin
  class DevCentersController < Admin::AdminController
    active_scaffold :dev_center do |config|
      config.columns = [:name]
    end
  end
end
