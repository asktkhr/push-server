class Message
  require 'pusher'
  require 'c2dm'

  def send_message params
    data = {}
    data[:url] = params[:url]
    if params[:receivers].class.eql?(Array)
      data[:receivers] = params[:receivers]
    else
      data[:receivers] = params[:receivers].split(",")
    end
    c2dm_receivers = []
    websocket_receivers = []

    data[:receivers].each do |value|
      receiver = Device.find_by_name value
      unless receiver.registration_id.blank?
        c2dm_receivers.push receiver.registration_id
      else
        websocket_receivers.push receiver.name
      end
    end

    unless c2dm_receivers.blank?
      send_url_by_c2dm data[:url], c2dm_receivers
    end

    unless websocket_receivers.blank?
      send_url_by_websocket data[:url], websocket_receivers, params[:socket_id]
    end
  end

  def send_url_by_c2dm url, receivers
    email = "mail@gmail.com"
    password = "pass"
    C2DM.authenticate!(email, password, "com.porunga.phone2phone")
    c2dm = C2DM.new
    receivers.each do | registration_id |
      c2dm.send_notification ({ :registration_id => registration_id, :data => { :message => url }, :collapse_ket => "biteme" })
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

end
