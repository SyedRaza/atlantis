class ApplicationController < Atlantis::AtlantisController

  #include SslRequirement
  before_filter :initialize_data
  layout :layout_by_resource
  theme 'white'

  def after_sign_in_path_for(resource_or_scope)
    session[:redirected_url].nil? ? '/' : session[:redirected_url]
  end

  rescue_from CanCan::AccessDenied do |exception|
    session[:redirected_url] ||= request.url
    flash[:error]            = "Access denied!"
    redirect_to '/login'
  end

  private
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    '/login'
  end

  #alias_method :rescue_action_locally, :rescue_action_in_public
  def layout_by_resource
    if devise_controller?
      "application_blank"
    else
      "application"
    end
  end

  def initialize_data
    if (current_user.respond_to? :time_zone)
      Time.zone         = current_user.time_zone || 'Central Time (US & Canada)'
      Time.zone_default = current_user.time_zone || 'Central Time (US & Canada)'
    else
      Time.zone = 'Central Time (US & Canada)'
    end
  end

  def side_tabs_for_periods(controller)
    options = Hash.new
    unless params[:side_tab_period].nil?
      period = params[:side_tab_period].to_sym
      case period
        when :all_active
        when :last_6_days
          options[:created_at_gt] = 6.days.ago
        when :today
          options[:created_at_gt] = 1.day.ago
        when :this_week
          options[:created_at_gt] = Date.today.beginning_of_week
        when :this_month
          options[:created_at_gt] = Date.today.beginning_of_month
        when :this_year
          options[:created_at_gt] = Date.today.beginning_of_year
        when :archives
          options[:created_at_lte] = Date.today.beginning_of_year
          case controller
            when :leads
              options[:lead_status_status_ne] = "Active"
            when :opportunities
              options[:opportunity_status_name_ne] = "Active"
            when :vteams
              options[:vteam_status_status_ne] = "Active"
          end
      end
      if period == :all_active
        case controller
          when :leads
            options[:lead_status_status_equals] = "active"
          when :opportunities
            options[:opportunity_status_name_equals] = "active"
          when :vteams
            options[:vteam_status_status_eq] = "active"
        end
      end
    end
    options
  end

  def side_tabs_for_alphabets(controller)
    options = Hash.new
    unless params[:alphabets].nil?
      case controller
        when :companies
          options[:title_starts_with_any] = [params[:alphabets].first, params[:alphabets].first.next, params[:alphabets].last] unless params[:alphabets] == 'all'
        when :contacts
          options[:first_name_starts_with_any] = [params[:alphabets].first, params[:alphabets].first.next, params[:alphabets].last] unless params[:alphabets] == 'all'
      end
    end
    options
  end

  def filters_for_associations(controller)
    options = Hash.new
    unless params[:term].nil?
      controller = controller.to_sym
      case controller
        when :contacts
          options[:first_name_or_last_name_like] = params[:term]
        when :companies
          options[:title_like] = params[:term]
      end
    end
    unless params[:filter].nil?
      filter     = params[:filter]
      controller = controller.to_sym

      case filter
        when 'title'
          if controller == :notes
            options[:parent_vteam_type_name_or_parent_lead_type_title_or_parent_opportunity_type_title_or_parent_contact_type_first_name_or_parent_contact_type_last_name_or_parent_company_type_title_like] = params[:value]
          else
            options[:title_like] = params[:value]
          end
        when "note-type"
          options[:type_title_contains] = params[:value]
        when "posted-by"
          options[:user_name_like] = params[:value]
        when "lead"
          options[:parent_type_equals] = "Lead"
          session[:filter]             = "Lead"
        when "vteam"
          options[:parent_type_equals] = "Vteam"
          session[:filter]             = "Vteam"
        when "opportunity"
          options[:parent_type_equals] = "Opportunity"
          session[:filter]             = "Opportunity"
        when "billing_mode"
          options[:billing_mode_id_equals] = params[:id]
        when "all_cat"
          options[:parent_type_contains_any] = ["Contact", "Company", "Lead", "Vteam", "Opportunity"]
          session[:filter]                   = "all_cat"
        when "contact"
          case controller
            when :notes
              options[:parent_type_equals] = "Contact"
              session[:filter]             = "Contact"
            else
              if controller == :leads
                options[:contact_first_name_like] = params[:value]
              else
                options[:contact_first_name_contains] = params[:value]
              end
          end
        when "company"
          case controller
            when :notes
              options[:parent_type_equals] = "Company"
              session[:filter]             = "Company"
            when :contacts
              options[:companies_title_like] = params[:value]
            else
              options[:company_title_like] = params[:value]
          end
        when "contact_directory"
          if params[:id].nil?
            options[:contact_directory_id_is_null] = true
          else
            options[:contact_directory_id_equals] = params[:id]
          end
        when "contact_status"
          if params[:id].nil?
            options[:contact_status_id_is_null] = true
          else
            options[:contact_status_id_equals] = params[:id]
          end
        when "contact_type"
          if params[:id].nil?
            options[:contact_type_id_is_null] = true
          else
            options[:contact_type_id_equals] = params[:id]
          end
        when "dm"
          options[:dev_manager_like] = params[:value]
        when "dev_center"
          options[:dev_center_id_equals] = params[:id]
        when "email"
          options[:emails_email_like] = params[:value]
        when "lead_type"
          options[:lead_type_id_equals] = params[:id]
        when "lead_status"
          options[:lead_status_id_equals] = params[:id]
        when "lead_source"
          options[:lead_source_id_equals] = params[:id]
        when "name"
          if (controller == :contacts)
            options[:first_name_or_last_name_like] = params[:value]
          else
            options[:name_like] = params[:value]
          end
        when "phone"
          options[:phones_phone_number_like] = params[:value]
        when "opportunity_status"
          options[:opportunity_status_id_equals] = params[:id]
        when "opportunity_type"
          options[:opportunity_type_id_equals] = params[:id]
        when "type"
          options[:opportunity_type_name_like] = params[:value]
        when "attendees"
          options[:attendees_like] = params[:value]
        when "location"
          options[:location_like] = params[:value]
        when "meeting_type"
          options[:meeting_type_id_equals] = params[:id]
        when "source"
          options[:lead_source_source_like] = params[:value]
        when "vteam_status"
          options[:vteam_status_id_equals] = params[:id]
        when "status"
          case controller
            when "opportunities"
              options[:opportunity_status_name_eq] = params[:value]
            when "vteams"
              options[:vteam_status_status_eq] = params[:value]
          end
      end
    end


    options
  end
end
