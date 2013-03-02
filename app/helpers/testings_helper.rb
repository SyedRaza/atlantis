module TestingsHelper

  def tlist(object, &block)
    content_tag :ul, capture(TestingBuilder.new(object), &block)
  end

  class TestingBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::UrlHelper
    attr_accessor :object, :output_buffer

    def initialize(object)
      @object        = object
      @output_buffer = nil
    end

    def item(&block)
      if block_given?
        content_tag(:li, capture(self, &block))
      end
    end
  end

  def m(&block)
    "this block returns #{block.call}" if block_given?
  end
end
