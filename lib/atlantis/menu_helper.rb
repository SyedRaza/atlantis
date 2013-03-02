require 'atlantis/menu_manager'
require 'atlantis/menu_helper'

module Atlantis
  module MenuManager
    module MenuHelper
      
      def current_url
        url = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
        { :controller=>url[:controller].to_sym, :action=>url[:action].to_sym }
      end

      def current_controller
        current_url[:controller]
      end

      def current_action
        current_url[:action]
      end

      def current_item (menu)
        (Atlantis::MenuManager.exists_by_url?(menu, current_url)) ?  (( Atlantis::MenuManager.item_by_url(menu, current_url) ) ) : nil
      end

      def current_is_root?( menu )
        item = current_item(menu)
        item != nil ? item.parent == menu ? true : false : false
      end

      def menu_items_for(menu)
        items = []
        Osbilling::MenuManager.item_root(menu).children.each do |node|
            items << node
        end
        items
      end

      # render the menu specified
      # *options* :link_class, :current_class, :ul_class, :li_class
      # *style* :tabs
      # *levels* :default=1
      def render_menu ( menu , options={}, style=:tabs , level=1 )
        links = []
        case style
        when :tabs
          Atlantis::MenuManager.items_at_level(menu, level).each do |node|
            links << render_menu_node(node, style, options)
          end
          links.empty? ? '' : content_tag('ul', links.join("\n").html_safe , :class=>options[:ul_class] ).html_safe
        when :divs
          Atlantis::MenuManager.items_at_level(menu, level-1).each do |node|
            links2 = Array.new
            node.children.each do |n|
              links2 << render_menu_node(n, style, options)
            end
            links <<  content_tag('div', links2.join("\n").html_safe).html_safe
          end
          links.empty? ? '' : links.join("\n").html_safe
        end
      end

      #render the menu node
      def render_menu_node(node, style=:tabs, options)
        caption, url, selected = extract_node_details(node)
        cls = ( selected ? options[:current_class] : options[:li_class] )
        case style
        when :tabs
          content_tag('li', render_link(caption, url, selected, options), :class=>cls).html_safe
        when :divs
          render_link(caption, url, selected, options).html_safe
        end
      end

      #render the single menu node
      def render_link(caption, url, selected, options)
        cls = ( selected ? options[:current_class] : options[:link_class] )
        logger.debug "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        logger.debug cls
        logger.debug "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        begin
          link_to(caption, url, {:class=> cls }).html_safe
        rescue
          link_to '', {:controller => '/' + url[:controller].to_s , :action => url[:action]}, {:class=> cls }
        end
      end

      #render the menu specified
      def render_breadcrumb ( menu , options )
        links = []
        item = current_item(menu)
        if item != nil
          links << render_breadcrumb_node(item, options)
          while item.parent != nil do
            if item.parent.is_a? Symbol
              links << link_to( 'Home', '/' , {:class=>options[:link_class]} ).html_safe + ' > '.html_safe
              break
            else
              links << render_breadcrumb_node(item.parent, options).html_safe + ' > '.html_safe
              item = item.parent
            end
          end
        end
        links = links.reverse
        links.empty? ? '' : content_tag('div', links.join("\n") , :class=>options[:div_class]).html_safe
      end
      
      #render the menu node
      def render_breadcrumb_node(node, options)
        caption, url, selected = extract_node_details(node)
        content_tag('span', render_single_breadcrumb_node(node, caption, url, selected, options), :class=>options[:span_class] ).html_safe
      end

      def render_single_breadcrumb_node(item, caption, url, selected, options)
        cls = ( selected ? options[:current_class] : options[:link_class] )
        begin
          link_to(caption, url, {:class=> cls }).html_safe
        rescue
          link_to('', {:controller => '/' + url[:controller].to_s , :action => url[:action]}, {:class=> cls}).html_safe
        end
      end

      def active_node? (node)
        node.url[:controller] == "/#{params["controller"]}"
      end

      #extract the node details from the link
      def extract_node_details(node)
        item = node
        url = item.url
        caption = item.caption
        selected = active_node?(node)
        [caption, url, selected ]
      end
      
    end
  end
end