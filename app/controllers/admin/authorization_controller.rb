module Admin
  class AuthorizationController < ApplicationController
    def index
      @roles     = Role.all
      @resources = SystemResource.notes("parent_resource ASC").all
      @resource  = SystemResource.find(1)
      @resources.each do |rs|
        @roles.each do |r|
          unless Permission.where("resource_id = ? AND role_id = ?", rs.id, r.id).exists?
            p          = Permission.new
            p.resource = rs
            p.role     = r
            p.save
          end
        end
      end
    end

    def set_permissions
      action = params[:action_to_do]
      mode   = params[:mode]
      pid    = params[:pid]
      p      = Permission.find_by_id(pid.to_i);
      case action
        when 'all'
          p.can_create = true
          p.can_delete = true;
          p.can_edit   = true;
          p.can_read   = true;
        when 'none'
          p.can_create = false
          p.can_delete = false;
          p.can_edit   = false;
          p.can_read   = false;
        when 'create'
          p.can_create = (mode == 'activate') ? true : false;
        when 'read'
          p.can_read = (mode == 'activate') ? true : false;
        when 'edit'
          p.can_edit = (mode == 'activate') ? true : false;
        when 'delete'
          p.can_delete = (mode == 'activate') ? true : false;
      end
      p.save
      render :json => [true]
    end
  end
end