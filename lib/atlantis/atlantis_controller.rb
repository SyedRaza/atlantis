# To change this template, choose Tools | Templates
# and open the template in the editor.

module Atlantis
  class AtlantisController < ActionController::Base

    protect_from_forgery
    helper Atlantis::MenuManager::MenuHelper
   
  end
end
