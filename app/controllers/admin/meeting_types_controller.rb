module Admin
  class MeetingTypesController < Admin::AdminController
    active_scaffold :meeting_types do |config|
      config.columns = [:meeting_type]
    end
  end
end