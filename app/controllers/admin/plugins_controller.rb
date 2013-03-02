module Admin
  class PluginsController < ApplicationController
    def index
      @plugins = Atlantis::PluginManager.all
    end

    def activate_plugin
      id = params[:pid]
      Atlantis::PluginManager.find(id).activate
      redirect_to :action => "index"
    end

    def deactivate_plugin
      id = params[:pid]
      Atlantis::PluginManager.find(id).deactivate
      redirect_to :action => "index"
    end
  end
end