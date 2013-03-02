class DashboardController < ApplicationController
  include Apotomo::Rails::ControllerMethods

  load_and_authorize_resource

  has_widgets do |root|
    root << widget('atlantis/daily_lead_count_widget', 'daily_lead_count', :display)
    root << widget('atlantis/daily_team_count_widget', 'daily_team_count', :display)
    root << widget('atlantis/monthly_lead_count_widget', 'monthly_lead_count', :display)
    root << widget('atlantis/monthly_team_count_widget', 'monthly_team_count', :display)
    root << widget('date_range_widget', 'date_range', :display)
  end

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def notes
    respond_to do |format|
      format.html
      format.js
    end
  end
end
