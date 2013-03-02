require 'test_helper'

class DateRangeWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:date_range_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
