class Message
  require 'pusher'

  def send_url url
    Pusher['channel_name'].trigger('event_name', url)

  end

end
