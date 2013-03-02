module Admin
  class FlagsController < Admin::AdminController
    active_scaffold :flags do |config|
      config.columns = [:name]
    end
  end
end
