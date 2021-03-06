# frozen_string_literal: true

# https://gist.github.com/henrik/1214011/7ffaa86636e5b5b1fe872f9273834373c58f7ab6
require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'

WillPaginate.per_page = 10

module BootstrapPaginationHelper
  class LinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

      def page_number(page)
        if page == current_page
          link(page, '#', class: 'active')
        else
          link(page, page, rel: rel_value(page))
        end
      end

      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<li class="page-item disabled"><a>#{text}</a></li>)
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], 'next')
      end

      def previous_page
        num = (@collection.current_page - 1 > 0) && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], 'previous')
      end

      def previous_or_next_page(page, text, classname)
        if page
          link(text, page, class: classname)
        else
          link(text, '#', class: classname + ' disabled')
        end
      end

      def html_container(html)
        tag(:nav, tag(:ul, html, class: 'pagination'), container_attributes)
      end

    private

      def link(text, target, attributes = {})
        if target.is_a? Integer
          attributes[:rel] = rel_value(target)
          target = url(target)
        end

        attributes[:href] = target unless target == '#'

        attributes[:class] ||= ''
        classname = attributes[:class]
        attributes[:class] += ' page-link'
        tag(:li, tag(:a, text, attributes), class: classname + ' page-item')
      end
  end
end
