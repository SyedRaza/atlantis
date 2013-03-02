require 'atlantis/data_list/helper'

module Atlantis
  module DataList
    @@data_list_tag = :ol
    @@list_tag      = :ul
  end
end

ActionView::Base.send :include, Atlantis::DataList::Helper