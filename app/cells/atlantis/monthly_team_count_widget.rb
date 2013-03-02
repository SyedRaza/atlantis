module Atlantis
  class MonthlyTeamCountWidget < Apotomo::Widget

    responds_to_event :team_total_months_changed, :with => :redraw
    @@months_to_show = 2

    def display
      @title              = "Team Count"
      @months_to_show     = @@months_to_show
      @monthly_lead_count = {}
      @total_months       = Date.today.month - Date.today.months_ago(@@months_to_show-1).month
      @total_months = 12 + @total_months if @total_months < 0
      status_key = VteamStatus.find_by_status("Active").id
      @min_count = 5000
      @max_count = 0
      @total_months.downto 0 do |m|
        @month  = Date.today.months_ago(m)
        @values = []
        counts = 0
        1.upto 31 do |d|
          if Date::valid_date?(@month.year, @month.month, d) and !(Date.parse("#{@month.year}-#{@month.month}-#{d}").to_date.future?)
            counts  = Vteam.count(
              :conditions => ["created_at <= ? AND vteam_status_id = ?", Date.parse("#{@month.year}-#{@month.month}-#{d}").to_date, status_key ]
            )
            @values << counts
          end
        end
        @min_count = @min_count < @values.min ? @min_count : @values.min
        @max_count = @max_count > @values.max ? @max_count : @values.max
        @monthly_lead_count[@month.strftime("%B %Y")] = @values
      end
      @days = []
      1.upto 31 do |d|
          @days << d
      end
      render :layout=>'portlet'
    end

    def redraw
      @@months_to_show = params[:total_months].to_i || 2
      replace :state => :display
    end

  end
end
