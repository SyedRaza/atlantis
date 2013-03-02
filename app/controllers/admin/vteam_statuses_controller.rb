module Admin
  class VteamStatusesController < Admin::AdminController
    active_scaffold :vteam_status do |config|
      config.columns = [:status]
    end
  end
end
