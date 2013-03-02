module ApplicationHelper

  def processed_pagination(object)
    content_tag(:div, will_paginate(object, {}), :class=>"list-pagination")
  end

  def link_with_icon(icon, link, state=nil, options={})
    state           ||= 'highlight'
    options[:class] = "ui-state-#{state} plus"
    link_to("<span class='ui-icon ui-icon-#{icon}'></span>".html_safe, link, *options)
  end

# Return a title on a per-page basis.
  def title
    base_title = "Atlantis #{Atlantis::VERSION}"
    #base_title = "Atlantis 1.0.0"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def escape_for_quotes(str)
    raw ("\"\"+<r><![CDATA[" + str+ "]]></r>")
  end

  def descriptive_title
    str = ""
    str += "of #{session[:filter].humanize} " unless session[:filter].nil?
    str += "during #{session[:limit].humanize}" unless session[:limit].nil?
    str
  end

  def show_full_date(date)
    "#{date.month}-#{date.day}-#{date.year}"
  end


  def show_signature(object)
    str = "<div id='signature' >"
    str += "<hr />"
    str += "<em>Created at </em><br />#{l object.created_at} <br />"
    str += "<em>by</em> #{object.user}<br /> " unless object.user.nil?
    str += "<em>Updated at </em><br />#{l object.updated_at} <br />"
    str += "<em>by</em> #{object.updated_by}<br /> " unless object.updated_by.nil?
    str += "</div>"
    str.html_safe
  end

  def awesome_truncate(text, length = 10, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.mb_chars.length
    text.mb_chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end

  def side_tabs_for_periods(controller, tabs_titles)
    links = []
    tabs_titles.each do |t|
      links << content_tag(:li, link_to(t, url_for(:controller=>controller, :action=>:index, :side_tab_period=>t.parameterize.underscore.to_sym), {:remote=>true, :class=>'selected'}))
    end
    raw content_tag(:ul, links.join("").html_safe)
  end

  def side_tabs_for_alphabets(controller)
    links = []
    links << content_tag(:li, link_to("All", url_for(:controller => controller, :action =>:index, :alphabets =>"all"), {:remote=>"true", :class => "selected"})).html_safe

    first  = 65
    second = nil
    last   = 90
    first.to_int.upto(last) do |i|
      if i % 3 == 0 and first != i then
        second = i
        links << content_tag(:li, link_to(first.chr+"-"+second.chr, url_for(:controller => controller, :action =>:index, :alphabets=>first.chr+"-"+second.chr), :remote=>"true")).html_safe
        first = i + 1
      end
    end
    raw content_tag(:ul, links.join("").html_safe)
  end

  def filters_for_associations(controller, associations)
    boxes = []
    model = controller.to_s.singularize.titleize.constantize
    associations.each do |a|
      a           = a.to_s
      links       = []
      assoc_model = a.camelize.constantize
      assoc_model.all.each do |record|
        count = model.where("#{a}_id = ?", record.id).count
        if count > 0
          links << link_to(
              "#{record.to_s} (#{count})",
              url_for(:controller =>controller, :action => :index, :filter => a, :id=>record.id),
              {:name =>record.to_s, :id=>record.id, :remote=>true}
          )
        end
      end
      count = model.where("#{a}_id IS ? ", nil).count
      if count > 0
        links << link_to("Uncategorized(#{count})", url_for(:controller =>controller, :action => :index, :filter => a, :id=>nil),
                         {:name =>"Uncategorized", :id=>"null", :remote=>true}
        )
      end
      boxes << content_tag(:dl, "#{content_tag :dt, "<h2>#{a.titleize}</h2>".html_safe} #{content_tag :dd, links.join('<br />').html_safe}".html_safe)
    end
    raw boxes.join("<br />")
  end

  def options_menu(&block)
    new_block = Proc.new do
      helper = ApplicationHelper::OptionsMenuHelper.new
      block.call(helper)
    end
    content_tag(:dl, "<dt><a href='#'>&nbsp;</a></dt>".html_safe + "<dd><ul>".html_safe + capture(&new_block) + "</ul></dd>".html_safe, :class=>'options')
  end

#helper for quick search on index and show views of all resources
#takes two parameters, first is the name of the view i.e index or show
#second parameter is an array of buttons that are required to search upon like title, phone, email etc
  def quick_search(view_id, names=[], url = "", method="script")
    case view_id
      when "index"
        id = "qfilter"
      when "show"
        id = "showfilter"
    end
    inputs = ""
    start  = "<h2>Quick Search</h2>
               <form class='simple_form' action=\""+url+"\" data-method=\""+method+"\">
               <div id='quick-search' >
                <input type='text' id='"+id+"'  /><input id='quick-search-go' class='button big' type='button' value='Go' />
               </div>
               <div id='filter-type' class='filter-type'>"
    names.each do |n|
      inputs +="<input type='radio' name='type' id='#{n}'/><label for='#{n}'>#{n.titleize}</label>"
    end
    close  = "</div></form>"
    script = capture do
      javascript_tag "$(document).ready(function(){
        initialize_filters(\"#{id}\")
      });"
    end
    (start + inputs + close + script.html_safe).html_safe
  end

  def count_leaves(id, type = "")
    days = 0
    if type!= ""
      vt        = VacationType.find_by_title(type)
      vacations = Vacation.search({:vacation_type_id_eq             =>vt.id,
                                   :resource_vteam_allocation_id_eq => id})
    else
      vacations = Vacation.search(:resource_vteam_allocation_id_eq => id)
    end
    vacations.each do |v|
      days = days + v.from.business_days_until(v.to + 1)
    end
    days
  end

  def business_days_between(date1, date2)
    date1.business_days_until(date2+1)
  end

  def show_for_row(title, value)
    raw '<dl class="wrapper"><dt class="label">'+title.to_s+'</dt><dd class="content">'+value.to_s+'</dd></dl>'
  end

  def print_time(seconds)
    min, sec = seconds.divmod(60)
    hour, min = min.divmod(60)
    "#{hour.to_s.rjust(2, '0')}:#{min.to_s.rjust(2, '0')}"
  end

  class OptionsMenuHelper
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::AssetTagHelper

    def item(text)
      content_tag :li, text
    end

  end
end
