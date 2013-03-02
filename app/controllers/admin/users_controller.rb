module Admin
  class UsersController < ApplicationController
    load_and_authorize_resource

    def index
      @users = User.order("name").all.paginate(:per_page=>User.per_page, :page=>params[:page])
    end

    def new
      @user = User.new
      @user.user_roles.build
      respond_to do |format|
        format.html
        format.js
      end
    end

    def create
      @user = User.new(params[:user])
#      @role = UserRole.new

      respond_to do |format|
        if @user.save
#          @role.role_id = params[:user][:role_ids]
#          @role.user_id = @user.id
#          @role.save
          format.html { redirect_to :action => "index" }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
      end
    end

    def edit
      @user         = User.find(params[:id])
      session[:uri] = request.referer
      @user.user_roles.build if @user.user_roles.blank?

      respond_to do |format|
        format.html
        format.js
        format.xml
      end
    end

    def update
      @user = User.find(params[:id])
      url   = session[:uri]
      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to(url, :notice => 'User was successfully updated.') }
          format.xml { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end

    #  def change_password
    #    @user = User.find(current_user)
    #    session[:uri] = request.referer
    #    respond_to do |format|
    #      format.html
    #      format.js
    #      format.xml
    #    end
    #  end
  end
end