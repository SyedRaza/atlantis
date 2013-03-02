class CompaniesController < ApplicationController
  load_and_authorize_resource
  helper :notes
  # GET /companies
  # GET /companies.xml

  def index

    tabs = side_tabs_for_alphabets(:companies)
    filters = filters_for_associations(:companies)

    if tabs.nil? and filters.nil?
      @companies = Company.paginate(:per_page=>Company.per_page, :page=>params[:page])
    else
      @companies = Company.order("title ASC").search(tabs.merge!(filters)).paginate(:per_page=>Company.per_page, :page=>params[:page])
    end
    
    respond_to do |format|
      format.html
      format.js
      format.json { render :json=>@companies.to_json(:include=>:industry) }
      format.xml { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=>@company.to_json(:include=>[:industry, :phones,]) }
      format.xml { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new
    @company.phones.build
    @company.websites.build
    @company.emails.build
    @company.addresses.build
    #@company.phones.phone_type.build
    respond_to do |format|
      format.html # new.html.erb
      format.js # new.html.erb
      format.xml { render :xml => @company }
    end
  end

  # GET /company/1/edit
  def edit

    session[:redirect] = request.referrer
    @company = Company.find(params[:id])
    if @company.phones.blank?
      @company.phones.build
    end
    if @company.websites.blank?
      @company.websites.build
    end
    if @company.emails.blank?
      @company.emails.build
    end
    if @company.addresses.blank?
      @company.addresses.build
    end
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company      = Company.new(params[:company])
    @company.user = current_user
    respond_to do |format|
      if @company.save
#        c = request.referrer.split("/")
#        logger.info "-----------------------------"
#        logger.debug request.referrer.split("/")
#        logger.debug c.length
#        logger.info "-----------------------------"
#        if c[3] == "contacts" or c[3] == "leads"
#        logger.info "inside comparison"
#        session[:company] = @company.id
#        end
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.js
        format.xml { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.js
        format.xml { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /company/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(session[:redirect], :notice => 'Company was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml { head :ok }
    end
  end

  def data_loader
    @company_data = Company.find(params[:id])
    render :partial => "data"
  end

  def quick_search


  end

end
