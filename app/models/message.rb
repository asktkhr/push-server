class Message
  require 'pusher'

  def send_url params
    data = {}
    data[:url] = params[:url]
    data[:receivers] = params[:receivers]

    begin
      Pusher['chrome2chrome'].trigger('open_url', data.to_json, params[:socket_id])
    rescue Pusher::Error => e
      p e
    end
  end
end
