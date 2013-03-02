module Atlantis
  class DailyLeadCountWidget < Apotomo::Widget

    after_add do |me, parent|
      me.root.respond_to_event :date_range_changed, :with => :redraw, :on => me.name
    end

    def display
      @title        = "Lead Count"
      counts        = Lead.count(
          :conditions => ["created_at >= ? AND created_at <= ?", session[:date_range_from].beginning_of_day, session[:date_range_to].end_of_day],
          :group      => "DATE(created_at)"
      )
      @lead_dates = []
      @lead_counts = []
      session[:date_range_from].to_date.upto session[:date_range_to].to_date do |d|
        @lead_dates<< d
        @lead_counts << (counts[d.to_date] || 0)
      end
      render :layout=>'portlet'
    end

    def redraw
      replace :state => :display
    end
  end
end
