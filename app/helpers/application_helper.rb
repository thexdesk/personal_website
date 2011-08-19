module ApplicationHelper
  
  def error_messages_for(object)
    render :partial => "shared/error_messages", :object => object
  end
    
  def format_timestamp(timestamp)
    return if timestamp.blank?
    timestamp.strftime("%m/%d/%Y %I:%M%p").downcase
  end
  
  def navigation_class(navigation_key)
    return "" unless controller.active_tab
    return "active" if navigation_key == controller.active_tab
    return ""
  end
  
  def button(text, options={})
    type = options[:type] || :submit
    content_tag(:button, text, :class => "button", :type => type)
  end
  
  def page_title
    return "#{@page_title} | Nick DeSteffen" if defined?(@page_title)
    title = controller.active_tab.present? ? controller.active_tab.capitalize : nil
    return "#{title} | Nick DeSteffen" if title
    return "Nick DeSteffen"
  end
  
end
