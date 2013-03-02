# To change this template, choose Tools | Templates
# and open the template in the editor.

module Atlantis

  class MenuTreeItem
    attr_accessor  :name, :url, :options, :parent, :children

    def initialize (name, url, options , parent)
      self.name = name
      self.url = url
      self.options = options
      self.parent = parent
      self.children = Array.new
    end
    def new( name, url, options, parent)
      self.name = name
      self.url = url
      self.options = options
      self.parent = parent
      self.children = Array.new
    end

    def has_children?
      self.children.length > 0
    end

    def caption
      self.options[:caption]
    end

    def html_options (option)
      self.options[option]
    end
  end
  
  class MenuTree < Object
    attr_accessor :all_items, :root_name, :all_urls
    
    def initialize ( name , url , options )
      self.all_items = Hash.new
      self.all_urls = Hash.new
      self.root_name = name
      self.all_items[name] = Atlantis::MenuTreeItem.new( name, url , options , nil)
      self.all_urls[url.to_s] = self.all_items[name]
    end
    
    def add ( name, url , options , parent_name=nil )
      if parent_name.nil?
        self.all_items[name] = Atlantis::MenuTreeItem.new( name, url, options, root_name)
        self.all_items[root_name].children << self.all_items[name]
      else
        self.all_items[name] = Atlantis::MenuTreeItem.new( name, url, options, self.all_items[parent_name])
        self.all_items[parent_name].children << self.all_items[name]
      end
      
      self.all_urls[url.to_s] = self.all_items[name]
    end

    def delete (name)
      self.all_urls[self.all_items[name].url.to_s].delete(self.all_items[name])
      self.all_items[name].delete(self.all_items[name])
    end

    def item_by_url (url)
        self.all_urls[url.to_s]
    end
    
    def item_by_name (name)
        self.all_items[name]
    end

    def root
      self.all_items[self.root_name]
    end

    def exists_by_name? (name)
      self.all_items.has_key?(name)
    end

    def exists_by_url? (url)
      self.all_urls.has_key?(url.to_s)
    end

    def items_at_level(level)
      if level == 0 
        root
      else
        items_at_level_rec(root, level)
      end
    end
    
    def items_at_level_rec(item, level, current_level=0)
      items = []
      if level == current_level 
        items << item
        items
      else
        item.children.each do |i|
          items += items_at_level_rec(i,level,current_level+1)
        end
        items
      end
    end
  end
end