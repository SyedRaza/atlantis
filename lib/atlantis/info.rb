module Atlantis
  # Class to show some info about the application
  module Info
    class << self
      def app_name; 'Atlantis' end
      def app_full_name; 'Atlantis - Missing Island of Informaiton' end
      def url; 'http://www.nextbridge.com.pk' end
      def help_url; 'http://www.nextbridge.com.pk/atlantis/wiki' end
      def versioned_name; "#{app_name} #{Atlantis::VERSION}" end
      def versioned_full_name; "#{app_full_name} #{Atlantis::VERSION}" end
    end
  end
end
