require 'pp'
class WebsocketController < ApplicationController
  protect_from_forgery :except => [:send_url, :register, :register_info]

  def send_url
    Message.new.send_url params
    render :nothing => true, :status => :ok
  end

  def register
    device = Device.new
    device.name = params[:name]
    device.extension_id = request.env["HTTP_ORIGIN"]
    if device.save 
      render :text => 'success', :status => :created
    else
      render :text => 'error', :status => :bad_request
    end
  end

  def register_info
    device = Device.find_by_extension_id(request.env["HTTP_ORIGIN"])
    render :json => device, :status => :ok
  end

  def receivers
    @devices = Device.where("extension_id <> ?", request.env["HTTP_ORIGIN"])
    render :layout => false, :status => :ok
  end
end
