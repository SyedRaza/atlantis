module Admin
  class AdminController < ApplicationController
    load_and_authorize_resource
    ActiveScaffold.set_defaults do |config|
      config.ignore_columns.add [:created_at, :updated_at]
    end
  end
end