module DataListHelper
  def list_headers(args=[])
    args    = Array.new(args)
    columns = []
    args.map { |o| columns << content_tag(:li, o.split(":").first, :style=>"width:#{o.split(":").second}px;") }
    content_tag(:ul, columns.join(" ").html_safe, :class=>"list-headers")
  end

  def data_list_total_records(array)
    content_tag(:div, page_entries_info(array).html_safe, :class=>"total-records")
  end

  def data_list_pagination(array)
    will_paginate array
  end

  def data_list_for(object, headers=[], &block)
    if object.is_a? Array
      if object.length == 0
        list_headers(headers).concat(content_tag(:strong, "<br />No records found".html_safe))
      else
        res_obj = data_list_total_records(object)
        res_obj << content_tag(:ol, :class=>"data-list") do
          res_ol = content_tag(:li) do
            res = list_headers(headers)
            object.each do |o|
              builder = DataListBuilder.new(o)
              res << content_tag(:li) do
                content_tag(:ul, :id=>o.id, :class=>"list-row #{cycle('odd', 'even')}") do
                  capture(builder, &block)
                  builder.output_buffer.html_safe
                end
              end
            end
            res
          end
          res_ol << data_list_pagination(object)
        end
        res_obj
      end
    else
      list_headers(headers).concat(content_tag(:strong, " <br />Not available."))
    end
  end

  class DataListBuilder
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::CaptureHelper
    include ActionView::Helpers::UrlHelper
    include Rails.application.routes.url_helpers

    attr_accessor :object, :output_buffer, :controller

    def initialize(object)
      @object, @output_buffer = object, ''
    end

    def column (&block)
      @output_buffer << if block_given?
                          content_tag(:li, instance_eval(&block))
                        else
                          content_tag(:li, "")
                        end
      nil
    end

    def options_column(&link_block)
      @output_buffer << if block_given?
                          content_tag(:li) do
                            content_tag(:dl, :class=>'options') do
                              res = content_tag(:dt) do
                                content_tag(:a, '&nbsp;'.html_safe, :href => '#')
                              end
                              res << content_tag(:dd) do
                                content_tag(:ul) do
                                  instance_eval &link_block
                                end
                              end
                            end
                          end
                        else
                          content_tag(:li, "")
                        end
      nil
    end

    def link_item(title, url, options={})
      if url.kind_of? String
        u = url
      else
        u = "/"
      end
      content_tag :li, link_to(title, u, options)
    end
  end
end