# To change this template, choose Tools | Templates
module Atlantis

  class PluginNotFound < StandardError; end
  class PluginRequirementError < StandardError; end
  
  class PluginManager
    @registered_plugins = {}
    class << self
      attr_reader :registered_plugins
      private :new
      def def_field(*names)
        class_eval do
          names.each do |name|
            define_method(name) do |*args|
              args.empty? ? instance_variable_get("@#{name}") : instance_variable_set("@#{name}", *args)
            end
          end
        end
      end
    end
    def_field :name, :description, :url, :author, :author_url, :version, :settings
    attr_reader :id

    # Plugin constructor
    def self.register(id, &block)
      p = new(id)
      p.instance_eval(&block)
      # Set a default name if it was not provided during registration
      p.name(id.to_s.humanize) if p.name.nil?
      # Adds plugin locales if any
      # YAML translation files should be found under <plugin>/config/locales/
      #::I18n.load_path += Dir.glob(File.join(RAILS_ROOT, 'vendor', 'plugins', id.to_s, 'config', 'locales', '*.yml'))

      registered_plugins[id] = p
    end

    # Returns an array off all registered plugins
    def self.all
      registered_plugins.values.sort
    end

    # Finds a plugin by its id
    # Returns a PluginNotFound exception if the plugin doesn't exist
    def self.find(id)
      registered_plugins[id.to_sym] || raise(PluginNotFound)
    end

    # Clears the registered plugins hash
    # It doesn't unload installed plugins
    def self.clear
      @registered_plugins = {}
    end

    # Checks if a plugin is installed
    #
    # @param [String] id name of the plugin
    def self.installed?(id)
      registered_plugins[id.to_sym].present?
    end
    
    def initialize(id)
      @id = id.to_sym
    end

    def <=>(plugin)
      self.id.to_s <=> plugin.id.to_s
    end

    # Returns +true+ if the plugin can be configured.
    def configurable?
      settings && settings.is_a?(Hash) && !settings[:partial].blank?
    end

    def activated?
      p = Plugin.find_by_name(id.to_s)
      p.respond_to?(:activated) ? p.activated : false
    end

    def activate
      # Executing Migrations
      #m_files = Dir.glob(File.join(Rails.root,'vendor','plugins',id.to_s,'db','migrate', '*.rb'))
      ActiveRecord::Migrator.migrate("vendor/plugins/#{self.id.to_s}/lib/db/migrate/", nil)
      Atlantis::Rake.call('db:schema:dump')
      
      p = Plugin.find_by_name(id.to_s)
      p = Plugin.new unless p.respond_to?(:activated)
      p.name = id.to_s
      p.activated = true
      p.save
    end

    def deactivate
      ActiveRecord::Migrator.down("vendor/plugins/#{self.id.to_s}/lib/db/migrate/", nil)
      Atlantis::Rake.call('db:schema:dump')
      p = Plugin.find_by_name(id.to_s)
      p.activated = false
      p.save
    end

  end
end
