module NotesHelper

  def show_types(types, base)
    links = "<dl id='x_doc_types_list' class='ui-menu ui-widget ui-widget-content ui-corner-all'>"
    types.each do |t|
        links += content_tag(:li, link_to(t.title, "#{base}/notes/new?type_id=#{t.id}"), :class=>'ui-menu-item')
    end
    links += "</dl>"
    links.html_safe
  end
  
  def show_types(types, base, abc=1)
    links = "<dl id='note_types_list' class='ui-menu ui-widget ui-widget-content ui-corner-all'>"
    types.each do |t|
        links += content_tag(:li, link_to(t.title, "#{base}/notes/new?type_id=#{t.id}"), :class=>'ui-menu-item')
    end
    links += "</dl>"
    links.html_safe
  end

  def render_note_type_menu(title=nil, base)
    title ||= "Select Note Type"
    types = NoteType.order("position ASC").all
    content_tag :div, (link_to(" <span class='ui-icon ui-icon-document'>&nbsp;</span> #{title}".html_safe, "#") + show_types(types, base, 626)).html_safe, :id=>'note_types_menu'
  end

  def show_type(type)
    str = Array.new
    str << type.title
#    unless type.parent.nil?
#      str << show_type(type.parent)
#    end
    str.reverse
  end
end
