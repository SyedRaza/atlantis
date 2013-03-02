module Admin
  class CountriesController < Admin::AdminController

    active_scaffold :country do |config|      
      config.columns = [:name]
    end
  end
end
