require 'test_helper'

class MonthlyLeadCountWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:monthly_lead_count_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
