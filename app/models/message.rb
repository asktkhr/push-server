class Message
  require 'pusher'

  def send_url params
    Pusher['chrome2chrome'].trigger('open_url', params[:url], params[:socket_id])
  end

end
