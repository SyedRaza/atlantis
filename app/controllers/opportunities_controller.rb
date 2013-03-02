class OpportunitiesController < ApplicationController
  load_and_authorize_resource :opportunity
  #ExampleWorker.async_create_new_records("This Person")
  helper :notes
  # GET /opportunities
  # GET /opportunities.xml
  def index

    tabs = side_tabs_for_periods(:opportunities)
    filters = filters_for_associations(:opportunities)
    
    if tabs.nil? and filters.nil?
      @opportunities = Opportunity.paginate(:per_page=>Opportunity.per_page, :page=>params[:page])
    else
      @opportunities = Opportunity.order("created_at DESC").search(tabs.merge!(filters)).paginate(:per_page=>Opportunity.per_page, :page=>params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @opportunities }
    end
  end

  # GET /opportunities/1
  # GET /opportunities/1.xml
  def show
    @opportunity = Opportunity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @opportunity }
    end
  end

  # GET /opportunities/new
  # GET /opportunities/new.xml
  def new
    @opportunity = Opportunity.new
    if params[:lead_id].present?
      @selection = Lead.find_by_id(params[:lead_id])
      @opportunity.source_type = "Lead"
      @opportunity.source_id = params[:lead_id]
    elsif params[:vteam_id].present?
      @selection = Vteam.find_by_id(params[:vteam_id])
      @opportunity.source_type = "Vteam"
      @opportunity.source_id = params[:vteam_id]
    end
    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @opportunity }
    end
  end

  # GET /opportunities/1/edit
  def edit
    @opportunity = Opportunity.find(params[:id])
 
  end

  # POST /opportunities
  # POST /opportunities.xml
  def create
    @opportunity = Opportunity.new(params[:opportunity])
    params[:opportunity][:source_title]  = params[:opportunity][:source_type].constantize.find(params[:opportunity][:source_id]).title
    respond_to do |format|
      if @opportunity.save
        format.html { redirect_to(@opportunity, :notice => 'Opportunity was successfully created.') }
        format.xml  { render :xml => @opportunity, :status => :created, :location => @opportunity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /opportunities/1
  # PUT /opportunities/1.xml
  def update
    @opportunity = Opportunity.find(params[:id])
    
    params[:opportunity][:source_title]  = params[:opportunity][:source_type].constantize.find(params[:opportunity][:source_id]).title
      
   

    respond_to do |format|
      if @opportunity.update_attributes(params[:opportunity])
        format.html { redirect_to(@opportunity, :notice => 'Opportunity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @opportunity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /opportunities/1
  # DELETE /opportunities/1.xml
  def destroy
    @opportunity = Opportunity.find(params[:id])
    @opportunity.destroy

    respond_to do |format|
      format.html { redirect_to(opportunities_url) }
      format.xml  { head :ok }
    end
  end
  
  def details
    @opportunity = Opportunity.find_by_id(params[:id])
    render "details"
  end

end
