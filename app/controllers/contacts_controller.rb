class ContactsController < ApplicationController
  load_and_authorize_resource
  helper :notes

  # GET /contacts
  # GET /contacts.xml
  def index

    tabs    = side_tabs_for_alphabets(:contacts)
    filters = filters_for_associations(:contacts)
   
    if tabs.nil? and filters.nil?
      #@contacts = Contact.paginate(:per_page=>Contact.per_page, :page=>params[:page])
      @contacts = Contact.includes(:emails,:phones,:companies,:contact_company_profiles).paginate(:per_page=>Contact.per_page, :page=>params[:page])
    else
      @contacts = Contact.includes(:emails,:phones,:companies,:contact_company_profiles).order("first_name ASC").search(tabs.merge!(filters)).paginate(:per_page=>Contact.per_page, :page=>params[:page])
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render :json=>@contacts.to_json(:include=>[:emails, :companies, :phones, :messengers]) }
      format.xml { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js # show.html.erb
      format.xml { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new
    @contact.phones.build
    @contact.websites.build
    @contact.emails.build
    @contact.messengers.build
    @contact.addresses.build
    @contact.contact_company_profiles.build
    #@contact.phones.phone_type.build
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact           = Contact.find(params[:id])
    #    if request.referrer.include?("leads/new")
    #      session[:redirect] = request.referrer
    #    else
    #      session[:redirect] = @contact
    #    end
    session[:redirect] = request.referrer
    if @contact.phones.blank?
      @contact.phones.build
    end
    if @contact.websites.blank?
      @contact.websites.build
    end
    if @contact.emails.blank?
      @contact.emails.build
    end
    if @contact.messengers.blank?
      @contact.messengers.build
    end
    if @contact.addresses.blank?
      @contact.addresses.build
    end
    if @contact.contact_company_profiles.blank?
      @contact.contact_company_profiles.build
    end
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    #@contact.pic?

    #    if params[:company].present?
    #      new_company = Company.new
    #      if params[:company][:phones_attributes]["0"][:phone_number].present? and params[:company][:phones_attributes]["0"][:phone_type_id].present?
    #        company_phones = new_company.phones.build
    #        company_phones.phone_type_id = params[:company][:phones_attributes]["0"][:phone_type_id]
    #        company_phones.phone_number = params[:company][:phones_attributes]["0"][:phone_number]
    #        company_phones.save
    #      end
    #      new_company.title = params[:company][:title]
    #      new_company.industry_id = params[:company][:industry_id]
    #      new_company.save
    #    end
    if params[:contact].present?
      @contact      = Contact.create(params[:contact])
      @contact.user = current_user
    end
    respond_to do |format|
      if @contact.save
        #        contact_association = ContactCompanyProfile.find_by_contact_id_and_company_id(@contact.id, Company.last.id)
        #        if contact_association.nil?
        #          new_contact_association = ContactCompanyProfile.new()
        #          new_contact_association.contact_id = @contact.id
        #          new_contact_association.company_id = Company.last.id
        #          new_contact_association.save
        #        end
        #        c = request.referrer.split("/")
        #        if c[3] == "leads"
        #        logger.info "inside comparison"
        #        session[:contact] = @contact.id
        #        end
        #        @contact_profile.contact_id = @contact.id
        format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
        format.js
        format.xml { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.js
        format.xml { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(session[:redirect], :notice => 'Contact was successfully updated.') }
        format.js { render "show" }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    #logger.info "temps_url"
    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml { head :ok }
    end
  end

end
