module ApplicationHelper

  BOOTSTRAP_FLASH_MAP = {
    notice: 'alert-success',
    alert:  'alert-danger',
    info:   'alert-info'
  }

  def bootstrap_class_for(name)
    BOOTSTRAP_FLASH_MAP.fetch(name.to_sym)
  end

  def flash_messages
    info = ''
    flash.each do |name, message|
      info << content_tag(:div, class: "alert #{bootstrap_class_for(name)}") do
        content_tag(:button, 'x', class: "close", data: {dismiss: 'alert'}) +
        message
      end
    end
    info.html_safe
  end

end
