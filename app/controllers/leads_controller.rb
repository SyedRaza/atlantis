class LeadsController < ApplicationController
  load_and_authorize_resource
  helper :notes
  helper :application

  #  before_filter :load
  #
  #  def load
  #    @leads = Lead.all
  #    @lead  = Lead.new
  #  end

  def index
    tabs    = side_tabs_for_periods(:leads)
    filters = filters_for_associations(:leads)

    if tabs.nil? and filters.nil?
      @leads = Lead.includes({:contact=>[:phones, :emails]}, :company).paginate(:per_page=>Lead.per_page, :page=>params[:page])
    else
      @leads = Lead.includes({:contact=>[:phones, :emails]}, :company).order("created_at DESC").search(tabs.merge!(filters)).paginate(:per_page=>Lead.per_page, :page=>params[:page])
    end

    respond_to do |format|
      format.html
      format.js
      format.xml { render :xml => @leads }
    end
  end

  # GET /leads/1
  # GET /leads/1.xml
  def show
    @lead = Lead.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @lead }
    end
  end

  # GET /leads/new
  # GET /leads/new.xml
  def new
    @lead = Lead.new
    @lead.opportunities.build
    @lead.build_contact
    @lead.contact.phones.build
    @lead.contact.emails.build
    @lead.contact.messengers.build
    @lead.build_company
    @lead.company.phones.build
    #    session[:contact_lead] = nil
    #    session[:company_lead] = nil

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @lead }
    end

  end

  # GET /leads/1/edit
  def edit
    @lead = Lead.find(params[:id])
    unless @lead.contact.nil?
      if @lead.contact.phones.blank?
        @lead.contact.phones.build
      else
        @lead.contact.phones = @lead.contact.phones[0..0]

      end
      if @lead.contact.emails.blank?
        @lead.contact.emails.build
      else
        @lead.contact.emails = @lead.contact.emails[0..0]
      end
      if @lead.contact.messengers.blank?
        @lead.contact.messengers.build
      else
        @lead.contact.messengers = @lead.contact.messengers[0..0]

      end
    else
      @lead.build_contact
      @lead.contact.phones.build
      @lead.contact.emails.build
      @lead.contact.messengers.build
    end

    if @lead.company.nil?
      @lead.build_company
      @lead.company.phones.build
    else
      if @lead.company.phones.blank?
        @lead.company.phones.build
      else
        @lead.company.phones = @lead.company.phones[0..0]
      end
    end
  end

  # POST /leads
  # POST /leads.xml
  def create

    if params[:lead][:contact_id].present?
      contact = Contact.find(params[:lead][:contact_id])
      contact.update_attributes(params[:lead][:contact_attributes])
      params[:lead].delete :contact_attributes
    end
    if params[:lead][:company_id].present?
      company = Company.find(params[:lead][:company_id])
      company.update_attributes(params[:lead][:company_attributes])
      params[:lead].delete :company_attributes
    end
    if params[:lead][:company_id].blank? and params[:lead][:company_attributes][:title].blank?
      params[:lead].delete :company_attributes
    end

    @lead = Lead.new(params[:lead])
    respond_to do |format|
      if @lead.save
        if @lead.company_id.present?
          contact_association = ContactCompanyProfile.find_by_contact_id_and_company_id(@lead.contact_id, @lead.company_id)
          if contact_association.nil?
            new_contact_association            = ContactCompanyProfile.new()
            new_contact_association.contact_id = @lead.contact_id
            new_contact_association.company_id = @lead.company_id
            new_contact_association.active     = 1
            new_contact_association.save
          end
        end
        if params[:opportunity]=="create_opportunity"
          format.html { redirect_to(new_lead_opportunity_url(@lead), :notice => 'Lead was successfully created.') }
        else
          format.html { redirect_to(@lead, :notice => 'Lead was successfully created.') }
        end
        format.js
        format.xml { render :xml => @lead, :status => :created, :location => @lead }
      else
        format.html { render :action => "new" }
        format.js
        format.xml { render :xml => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leads/1
  # PUT /leads/1.xml
  def update
    if params[:lead][:contact_id].present?
      contact = Contact.find(params[:lead][:contact_id])
      contact.update_attributes(params[:lead][:contact_attributes])
      params[:lead].delete :contact_attributes
    else
      contact = Contact.new(params[:lead][:contact_attributes])
      contact.save
      params[:lead].delete :contact_attributes
      params[:lead][:contact_id] = contact.id
    end

    if params[:lead][:company_id].blank? and params[:lead][:company_attributes][:title].blank?
      params[:lead].delete :company_attributes
    else
      if params[:lead][:company_id].present?
        company = Company.find(params[:lead][:company_id])
        company.update_attributes(params[:lead][:company_attributes])
        params[:lead].delete :company_attributes
      else
        company = Company.new(params[:lead][:company_attributes])
        company.save
        params[:lead].delete :company_attributes
        params[:lead][:company_id] = company.id
      end
    end


    @lead = Lead.find(params[:id])
    respond_to do |format|
      if @lead.update_attributes(params[:lead])
        if @lead.company_id.present?
          contact_association = ContactCompanyProfile.find_by_contact_id_and_company_id(@lead.contact_id, @lead.company_id)
          if contact_association.nil?
            new_contact_association            = ContactCompanyProfile.new()
            new_contact_association.contact_id = @lead.contact_id
            new_contact_association.company_id = @lead.company_id
            new_contact_association.active     = 1
            new_contact_association.save
          end
        end
        format.html { redirect_to(@lead, :notice => 'Lead was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.xml
  def destroy
    @lead = Lead.find(params[:id])
    @lead.destroy
    flash[:notice] = "lead successfully deleted"
    @leads         = Lead.all
  end

  def details
    @lead = Lead.find_by_id(params[:id])
    render "details"
  end

  def add_docs
    @lead = Lead.find(params[:id])
    @lead.build_documents

    respond_to do |format|
      format.js { render :partial => "xdoc" }
      format.html
    end
  end
end