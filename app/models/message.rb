class Message
  require 'pusher'
  require 'c2dm'

  def send_message params
    data = {}
    data[:url] = params[:url]
    data[:receivers] = params[:receivers]
    c2dm_receiver = ""
    websocket_receivers = []

    data[:receivers].each do |value|
      receiver = Device.find_by_name value
      unless receiver.registration_id.blank?
        c2dm_receiver = receiver.registration_id
      else
        websocket_receivers.push receiver.name
      end
    end

    unless websocket_receivers.blank?
      send_url_by_websocket data[:url], websocket_receivers, params[:socket_id]
    end
    
    unless c2dm_receiver.blank?
      send_url_by_c2dm data[:url], websocket_receiver
    end
  end


  def send_url_by_websocket url, receivers, socket_id
    data = {}
    data[:url] = url
    data[:receivers] = receivers

    begin
      Pusher['chrome2chrome'].trigger('open_url', data.to_json, socket_id)
    rescue Pusher::Error => e
      p e
    end
  end

  def send_url_by_c2dm url, registration_id
    email = "pj.porunga@gmail.com"
    password = "xenlon2011"
    c2dm = C2DM.new(email, password, "com.porunga.phone2phone")
    notification = { :registration_id => registration_id, :data => { :message => url }, :collapse_ket => "biteme" }
    c2dm.send_notification(notification)
  end
end
