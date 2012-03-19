class Message
  require 'pusher'

  def send_url params
    begin
      Pusher['chrome2chrome'].trigger('open_url', params[:url], params[:socket_id])
    rescue Pusher::Error => e
      p e
    end
  end
end
