module Atlantis
  class DailyTeamCountWidget < Apotomo::Widget
    after_add do |me, parent|
      me.root.respond_to_event :date_range_changed, :with => :redraw, :on => me.name
    end

    def display
      @title        = "Daily Team Count"
      counts        = Vteam.count(
          :conditions => ["created_at >= ? AND created_at <= ?", session[:date_range_from].beginning_of_day, session[:date_range_to].end_of_day],
          :group      => "DATE(created_at)"
      )
      @team_dates = []
      @teams_count = []
      session[:date_range_from].to_date.upto session[:date_range_to].to_date do |d|
        @team_dates << d
        @teams_count << (counts[d.to_date] || 0)
      end
      render :layout=>'portlet'
    end

    def redraw
      @leads = Lead.first
      @redraw= true
      replace :state => :display
    end
  end
end
