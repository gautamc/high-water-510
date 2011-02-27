require 'will_paginate'
require 'will_paginate/view_helpers/link_renderer'

class UJSLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
      
  protected
  
  def page_number(page)
    unless page == current_page
      link(page, page, :rel => rel_value(page), "data-remote" => "true")
    else
      tag(:em, page)
    end
  end
  
  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, :class => classname, "data-remote" => "true")
    else
      tag(:span, text, :class => classname + ' disabled')
    end
  end
  
end
   
