require 'test_helper'

class MonthlyTeamCountWidgetTest < Apotomo::TestCase
  has_widgets do |root|
    root << widget(:monthly_team_count_widget, 'me')
  end
  
  test "display" do
    render_widget 'me'
    assert_select "h1"
  end
end
