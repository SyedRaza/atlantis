class VteamsController < ApplicationController
  load_and_authorize_resource
  helper :notes
  
  # GET /vteams
  # GET /vteams.xml
  def index

    tabs = side_tabs_for_periods(:vteams)
    filters = filters_for_associations(:vteams)

    if tabs.nil? and filters.nil?
      @vteams = Vteam.paginate(:per_page=>Vteam.per_page, :page=>params[:page])
    else
      @vteams = Vteam.order("created_at DESC").search(tabs.merge!(filters)).paginate(:per_page=>Vteam.per_page, :page=>params[:page])
    end

    respond_to do |format|
      format.html
      format.js
      format.xml  { render :xml => @vteams }
    end
  end

  # GET /vteams/1
  # GET /vteams/1.xml
  def show
    @vteam = Vteam.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vteam }
      format.json { render :json=> @vteam }
    end
  end

  # GET /vteams/new
  # GET /vteams/new.xml
  def new
    #refer_by = params[:by]
    #refer_by.to_s.camelize.constantize.find(params[:parent_id])
    @vteam = Vteam.new
    unless params[:parent_id].nil?
      @vteam.lead = Lead.find(params[:parent_id])
    end
    #@attach = @vteam.attaches.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vteam }
    end
  end

  # GET /vteams/1/edit
  def edit
    @vteam = Vteam.find(params[:id])
  end

  # POST /vteams
  # POST /vteams.xml
  def create
    @vteam = Vteam.new(params[:vteam])
    @vteam.user = current_user
    #@attach = @vteam.attaches.new(params[:vteam][:attach])
    #@attach.save
    respond_to do |format|
      if @vteam.save
        if params[:opportunity]=="create_opportunity"
          format.html { redirect_to(new_vteam_opportunity_url(@vteam), :notice => 'Vteam was successfully created.') }
        else
          format.html { redirect_to(@vteam, :notice => 'Vteam was successfully created.') }
        end
        format.xml  { render :xml => @vteam, :status => :created, :location => @vteam }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vteam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vteams/1
  # PUT /vteams/1.xml
  def update
    @vteam = Vteam.find(params[:id])

    respond_to do |format|
      if @vteam.update_attributes(params[:vteam])
        format.html { redirect_to(@vteam, :notice => 'Vteam was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vteam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vteams/1
  # DELETE /vteams/1.xml
  def destroy
    @vteam = Vteam.find(params[:id])
    @vteam.destroy

    respond_to do |format|
      format.html { redirect_to(vteams_url) }
      format.xml  { head :ok }
    end
  end

  def details
    @vteam = Vteam.find_by_id(params[:id])
    render "details"
  end

end
