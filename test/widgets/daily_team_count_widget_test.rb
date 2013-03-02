require 'test_helper'

class DailyTeamCountWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:daily_team_count_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
