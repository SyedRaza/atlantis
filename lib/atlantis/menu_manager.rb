# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'atlantis/menu_tree'

module Atlantis
  module MenuManager
    @menues
    
    class << self
      def initialize
        @menues ||= Hash.new
      end

      def add(menu_name, name, url, options={})
        @menues = Hash.new if @menues == nil
        if @menues.has_key?(menu_name)
          @menues[menu_name].add(name, url, options, options[:parent])
        else
          @menues[menu_name] = MenuTree.new( menu_name, {}, nil)
          @menues[menu_name].add(name, url, options, options[:parent])
        end
      end

      def add_menu_item (menu_name, name, url, options)
        add(menu_name, name, url, options)
      end

      # Removes a menu item
      def delete(menu_name, name)
        if @menues[menu_name]
          @menues[menu_name].delete(name)
        end
      end
      alias :delete_menu_item :add

      def exists_by_name? (menu_name, name)
        ( @menues.has_key? menu_name ) ? (( @menues[menu_name].exists_by_name?(name) ? true : false  )) : false
      end

      def exists_by_url? (menu_name, url)
        if @menues.has_key? (menu_name)
          if @menues[menu_name].exists_by_url?(url)
            true
          else
            false
          end
        else
          false
        end
      end
      
      def item_root (menu_name)
        @menues[menu_name].root
      end

      def item_by_name (menu_name, name)
        @menues[menu_name].item_by_name (name)
      end

      def item_by_url (menu_name, url)
        @menues[menu_name].item_by_url (url)
      end

      def items_at_level(menu_name,level)
        @menues[menu_name].items_at_level(level)
      end
    end
  end
end
