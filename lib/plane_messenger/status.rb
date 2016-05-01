module PlaneMessenger
  module Status
    CHANNEL = '/messages/plane_status'

    def self.change(plane)
      js_script = "var $plane = $('.plane[data-id=' + #{plane.id} + ']');
        $plane.find('.status').html('#{plane.status}');
        $plane.find('.takeoff').attr('disabled', '#{plane.status}' !== 'pending');
        $plane.find('.landing').attr('disabled', '#{plane.status}' !== 'flight');"
      message = {channel: CHANNEL, data: js_script}
      
      uri = URI.parse(Rails.application.config.dashboard.faye_uri)
      Net::HTTP.post_form(uri, message: message.to_json)
    end
  end
end
