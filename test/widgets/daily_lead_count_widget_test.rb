require 'test_helper'

class DailyLeadCountWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:daily_lead_count_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
