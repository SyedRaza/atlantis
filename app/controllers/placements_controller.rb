class PlacementsController < ApplicationController
  load_and_authorize_resource
  helper :notes
  # GET /placements
  # GET /placements.xml
  def index

    @search = Placement.search

    tabs = side_tabs_for_periods(:placements)

#    unless params[:search].nil?
#      options.merge!(params[:search])
#    end

    if tabs.nil?
      @placements = Placement.paginate(:per_page => Placement.per_page,:page=>params[:page])
    else
      @placements = Placement.order("created_at DESC").search(tabs).paginate(:per_page => Placement.per_page,:page=>params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @placements }
    end
  end

  # GET /placements/1
  # GET /placements/1.xml
  def show
    @placement = Placement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @placement }
    end
  end

  # GET /placements/new
  # GET /placements/new.xml
  def new
    if params[:copy_id].nil?
      @placement = Placement.new
    else
      @placement = Placement.find(params[:copy_id]).clone
      @placement.date_effective = Date.today;
    end
      
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @placement }
    end
  end

  # GET /placements/1/edit
  def edit
    @placement = Placement.find(params[:id])
  end

  # POST /placements
  # POST /placements.xml
  def create
    @placement = Placement.new(params[:placement])
    
    respond_to do |format|
      if @placement.save
        format.html { redirect_to(@placement, :notice => 'Placement was successfully created.') }
        format.xml  { render :xml => @placement, :status => :created, :location => @placement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @placement.errors, :status => :unprocessable_entity }
      end
    end
  end

  def details
    @placement = Placement.find_by_id(params[:id])
    render "details"
  end
  # PUT /placements/1
  # PUT /placements/1.xml
  def update
    @placement = Placement.find(params[:id])
    @placement.user = current_user

    respond_to do |format|
      if @placement.update_attributes(params[:placement])
        format.html { redirect_to(@placement, :notice => 'Placement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @placement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /placements/1
  # DELETE /placements/1.xml
  def destroy
    @placement = Placement.find(params[:id])
    @placement.destroy

    respond_to do |format|
      format.html { redirect_to(placements_url) }
      format.xml  { head :ok }
    end
  end
end
