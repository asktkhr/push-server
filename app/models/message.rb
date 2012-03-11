class Message
  require 'pusher'

  def send_url params
    Pusher['channel_name'].trigger('event_name', params[:url], params[:socket_id])
  end

end
