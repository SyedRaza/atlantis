class ResourceVteamAllocationsController < ApplicationController
  # GET /resource_vteam_allocations
  # GET /resource_vteam_allocations.xml
  def index
    @resource_vteam_allocations          = ResourceVteamAllocation.
        search(:vteam_id_eq => params[:vteam_id].to_i).
        paginate(:per_page => Placement.per_page, :page=>params[:page])


    @resource_vteam_allocations_active   = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => true}).paginate(:per_page => Placement.per_page, :page=>params[:page])
    @resource_vteam_allocations_deactive = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => false}).paginate(:per_page => Placement.per_page, :page=>params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.js { render :partial => "list" }
      format.xml { render :xml => @resource_vteam_allocations_active }
    end
  end

  # GET /resource_vteam_allocations/1
  # GET /resource_vteam_allocations/1.xml
  def show
    @resource_vteam_allocation = ResourceVteamAllocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @resource_vteam_allocation }
      format.json { render :json=>@resource_vteam_allocation.resource.to_json(:include=>[:name, :billing_rate]) }
    end
  end

  # GET /resource_vteam_allocations/new
  # GET /resource_vteam_allocations/new.xml
  def new
    @resource_vteam_allocation       = ResourceVteamAllocation.new
    @resource_vteam_allocation.vteam = Vteam.find(params[:vteam_id])
    selected_resource                = ResourceVteamAllocation.select(:resource_id).find_all_by_vteam_id_and_active(params[:vteam_id], true)
    selected_resource.map! { |a| a=a.resource_id }
    @selected_resource = Resource.search(:id_not_in=>selected_resource).all
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @resource_vteam_allocation }
    end
  end

  def release
    @resource_vteam_allocation        = ResourceVteamAllocation.find(params[:rid])
    @resource_vteam_allocation        = ResourceVteamAllocation.find(params[:rid])
    @resource_vteam_allocation.active = false

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @resource_vteam_allocation }
    end
  end

  # GET /resource_vteam_allocations/1/edit
  def edit
    @resource_vteam_allocation = ResourceVteamAllocation.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @resource_vteam_allocation }
    end
  end

  # POST /resource_vteam_allocations
  # POST /resource_vteam_allocations.xml
  def create
    params[:resource_vteam_allocation][:billing_rate] = ((params[:resource_vteam_allocation][:billing_rate].to_f * 10**2).round.to_f / 10**2).to_s
    @resource_vteam_allocation                        = ResourceVteamAllocation.new(params[:resource_vteam_allocation])
    @resource_vteam_allocation.vteam                  = Vteam.find(params[:vteam_id])

    # Declare @resource_vteam_count to check whether Resource already exist in particular Vteam as Active member
    @resource_vteam_count                             = ResourceVteamAllocation.find_all_by_resource_id_and_vteam_id_and_active(@resource_vteam_allocation.resource.id, @resource_vteam_allocation.vteam.id, true).count;

    @resource_vteam_allocation.active                 = true;
    respond_to do |format|
      unless @resource_vteam_count > 0
        if @resource_vteam_allocation.save
          #        format.html { redirect_to(vteam_resource_vteam_allocation_path(@resource_vteam_allocation.vteam,  @resource_vteam_allocation), :notice => 'Resource vteam allocation was successfully created.') }
          @resource_vteam_allocations_active   = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => true}).paginate(:per_page => Placement.per_page, :page=>params[:page])
          @resource_vteam_allocations_deactive = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => false}).paginate(:per_page => Placement.per_page, :page=>params[:page])
          format.html # new.html.erb
          format.js
          format.xml { render :xml => @resource_vteam_allocation, :status => :created, :location => @resource_vteam_allocation }
        else
          #        format.html { render :action => "new" }
          format.xml { render :xml => @resource_vteam_allocation.errors, :status => :unprocessable_entity }
        end
      else
        format.html # new.html.erb
        format.js
        format.xml { render :xml => @resource_vteam_allocation, :status => :created, :location => @resource_vteam_allocation }
      end
    end
  end

  # PUT /resource_vteam_allocations/1
  # PUT /resource_vteam_allocations/1.xml
  def update
    @resource_vteam_allocation = ResourceVteamAllocation.find(params[:id])
    unless params[:resource_vteam_allocation][:billing_rate].nil?
      params[:resource_vteam_allocation][:billing_rate] = ((params[:resource_vteam_allocation][:billing_rate].to_f * 10**2).round.to_f / 10**2).to_s
    end
    respond_to do |format|
      if @resource_vteam_allocation.update_attributes(params[:resource_vteam_allocation])
        @resource_vteam_allocations_active   = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => true}).paginate(:per_page => Placement.per_page, :page=>params[:page])
        @resource_vteam_allocations_deactive = ResourceVteamAllocation.order("created_at DESC").search({:vteam_id_eq => params[:vteam_id].to_i, :active_eq => false}).paginate(:per_page => Placement.per_page, :page=>params[:page])
        format.html # new.html.erb
        format.js
        format.xml { head :ok }
      else
        format.xml { render :xml => @resource_vteam_allocation.errors, :status => :unprocessable_entity }
      end
    end
  end

  def details
    @resource_vteam_allocation = ResourceVteamAllocation.find(params[:rid])
    render "details"
  end

  # DELETE /resource_vteam_allocations/1
  # DELETE /resource_vteam_allocations/1.xml
  def destroy
    @resource_vteam_allocation = ResourceVteamAllocation.find(params[:id])
    @resource_vteam_allocation.destroy

    respond_to do |format|
      format.html { redirect_to(resource_vteam_allocations_url) }
      format.xml { head :ok }
    end
  end
end
