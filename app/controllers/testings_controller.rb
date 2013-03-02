class TestingsController < ApplicationController
  # GET /testings
  # GET /testings.xml
  def index
    #@testings = Testing.all

    if params[:start_date].nil?
      @start_date = Date.today
    else
      @start_date = params[:start_date].to_datetime
    end
    if params[:end_date].nil?
      @end_date = Date.today
    else
      @end_date = params[:end_date].to_datetime
    end
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @testings }
    end
  end

  # GET /testings/1
  # GET /testings/1.xml
  def show
    @testing = Testing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @testing }
    end
  end

  # GET /testings/new
  # GET /testings/new.xml
  def new
    @testing = Testing.new
    @testing.build_documents

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @testing }
    end
  end

  # GET /testings/1/edit
  def edit
    @testing = Testing.find(params[:id])
    #@testing.build_documents
  end

  # POST /testings
  # POST /testings.xml
  def create
    logger.debug "---------------------"
    logger.debug "---------------------"
    @testing = Testing.new(params[:testing])

    respond_to do |format|
      if @testing.save
        format.html { redirect_to(@testing, :notice => 'Testing was successfully created.') }
        format.xml { render :xml => @testing, :status => :created, :location => @testing }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @testing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /testings/1
  # PUT /testings/1.xml
  def update
    logger.debug "---------------------"
    logger.debug "---------------------"
    @testing = Testing.find(params[:id])

    respond_to do |format|
      if @testing.update_attributes(params[:testing])
        format.html { redirect_to(@testing, :notice => 'Testing was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @testing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /testings/1
  # DELETE /testings/1.xml
  def destroy
    @testing = Testing.find(params[:id])
    @testing.destroy

    respond_to do |format|
      format.html { redirect_to(testings_url) }
      format.xml { head :ok }
    end
  end

  private

  def days_in_month(year, month)
    (Date.new(year, 12, 31) << (12-month)).day
  end
  def days_between_dates(first, last)
    (YMD(last) - YMD(first))
  end

  def YMD(date)
    date.to_date.to_s.gsub("-", "").to_i
  end


end

