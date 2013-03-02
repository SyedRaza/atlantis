require 'test_helper'

class MonthPickerWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:month_picker_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
