class VacationsController < ApplicationController
  # GET /vacations
  # GET /vacations.xml
  def index
    #@vacations = Vacation.all
    @vacations = Vacation.order("`vacations`.created_at DESC").search(
      {:resource_vteam_allocation_vteam_id_eq =>params[:vteam_id],
        :resource_vteam_allocation_active_eq =>true})
    .group(:resource_vteam_allocation_id)
    .paginate(:per_page => Vacation.per_page,:page=>params[:page])
    @vacation_type = VacationType.all
    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "list" }
      format.xml  { render :xml => @vacations }
    end
  end

  # GET /vacations/1
  # GET /vacations/1.xml
  def show
    @vacation = Vacation.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vacation }
    end
  end

  # GET /vacations/new
  # GET /vacations/new.xml
  def new
    @vteam = Vteam.find(params[:vteam_id])
    @vacation = Vacation.new
    @allocations = ResourceVteamAllocation.find_all_by_vteam_id_and_active(params[:vteam_id],true)

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @vacation }
    end
  end

  # GET /vacations/1/edit
  def edit
    @vteam = Vteam.find(params[:vteam_id])
    @vacation = Vacation.find(params[:id])
    @allocations = ResourceVteamAllocation.find_all_by_vteam_id_and_active(params[:vteam_id],true)

    

  end

  # POST /vacations
  # POST /vacations.xml
  def create
    @vacation = Vacation.new(params[:vacation])
    respond_to do |format|
      if @vacation.save
        @vacations = Vacation.order("`vacations`.created_at DESC").search(
          {:resource_vteam_allocation_vteam_id_eq =>params[:vteam_id],
            :resource_vteam_allocation_active_eq =>true})
        .group(:resource_vteam_allocation_id)
        .paginate(:per_page => Vacation.per_page,:page=>params[:page])
        @vacation_type = VacationType.all
        format.html
        format.js
        format.xml  { render :xml => @vacation, :status => :created, :location => @vacation }
      else
        #        format.html { render :action => "new" }
        format.xml  { render :xml => @vacation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vacations/1
  # PUT /vacations/1.xml
  def update
    @vacation = Vacation.find(params[:id])

    respond_to do |format|
      if @vacation.update_attributes(params[:vacation])
        #        format.html { redirect_to(vteam_vacations_path(@vacation.resource_vteam_allocation.vteam,@vacation), :notice => 'Vacation was successfully updated.') }

        format.html #{ redirect_to(@vacation, :notice => 'Vacation was successfully updated.') }
        @vacations = Vacation.order("created_at DESC").search(
          :resource_vteam_allocation_vteam_id_eq =>params[:vteam_id] ).
          paginate(:per_page => Vacation.per_page,:page=>params[:page])
        format.js

        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vacation.errors, :status => :unprocessable_entity }
      end
    end
  end

  def details
    @vacations = Vacation.find_all_by_resource_vteam_allocation_id(params[:rid])
    # @resource = ResourceVteamAllocation.find(params[:rid]).resource
    render "details"
  end

  # DELETE /vacations/1
  # DELETE /vacations/1.xml
  def destroy
    @vacation = Vacation.find(params[:id])
    @vacation.destroy

    respond_to do |format|
      format.html { redirect_to(vacations_url) }
      format.xml  { head :ok }
    end
  end
end
