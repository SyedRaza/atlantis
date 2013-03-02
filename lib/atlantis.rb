require 'atlantis/rake'
require 'atlantis/menu_helper'
require 'atlantis/menu_manager'
require 'atlantis/atlantis_controller'
require 'atlantis/info'
require 'atlantis/plugin_manager'
require 'atlantis/active_record'
require 'atlantis/data_list'

# Main module for handling all applicaiton behavior
module Atlantis
  # module to locate the version of the application
  module VERSION
    MAJOR  = 1
    MINOR  = 0
    TINY   = 0

    #CODE = 'First Flight'

    ARRAY  = [MAJOR, MINOR, TINY].compact
    STRING = ARRAY.join('.')

    def self.to_a;
      ARRAY
    end

    def self.to_s;
      STRING
    end
  end
end
