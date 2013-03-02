class DateRangeWidget < Apotomo::Widget
  responds_to_event :submit, :with => :process_tweet

  def display
    session[:date_range_from] = 1.week.ago
    session[:date_range_to] = Date.today
    render
  end

  def process_tweet
    session[:date_range_from] = params[:from].to_date
    session[:date_range_to] = params[:to].to_date
    trigger :date_range_changed
  end
  
end
