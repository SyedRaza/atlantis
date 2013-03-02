module GoodDataListHelper
  attr_accessor :object, :array

  class GoodDataList < BlockHelpers::Base
    attr_accessor :current_object

    def initialize(object)
      helper.array  = object
      helper.object = helper.array.first
      nil
    end

    def column(attribute, options={})
      content_tag :li, helper.object.send(attribute), options
    end

    def blank_column(options={}, &block)
      content_tag :li, capture(&block), options
    end

    def display(body)
      str = ''
      helper.array.each do |o|
        helper.object = o
        str << content_tag(:li, content_tag(:ul, body, :class=>'data-row'))
      end
      content_tag :ol, str.html_safe, :class=>'data-list'
    end
  end
end