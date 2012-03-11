class Message
  require 'pusher'

  Pusher.app_id = 'app_id'
  Pusher.key = 'app_key'
  Pusher.secret = 'app_secret'

  def send_url url
    Pusher['channel_name'].trigger('event_name', url)

  end

end
