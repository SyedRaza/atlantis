module Atlantis
  class MonthlyLeadCountWidget < Apotomo::Widget
    responds_to_event :lead_total_months_changed, :with => :redraw
    @@months_to_show = 2

    def display
      @title              = "Lead Count"
      @months_to_show = @@months_to_show
      @monthly_lead_count = {}
      @total_months       = Date.today.month - Date.today.months_ago(@@months_to_show-1).month
      @total_months = 12 + @total_months if @total_months < 0
      @max_count = 0
      #days = 0
      @total_months.downto 0 do |m|
        @month  = Date.today.months_ago(m)
        #days = Time::days_in_month(@month.month, @month.year)
        counts  = Lead.count(
            :conditions => ["created_at >= ? AND created_at <= ?", @month.beginning_of_month.beginning_of_day, @month.end_of_month.end_of_day],
            :group      => "DATE(created_at)"
        )
        @values = []
        1.upto 31 do |d|
          if Date::valid_date?(@month.year, @month.month, d) and !(Date.parse("#{@month.year}-#{@month.month}-#{d}").to_date.future?)
            @values << (counts[Date.parse("#{@month.year}-#{@month.month}-#{d}").to_date] || 0)
          end
        end
        @max_count = (@max_count > @values.max) ? @max_count : @values.max 
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
