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
    if device.save 
      render :text => 'success', :status => :created
    else
      render :text => 'error', :status => :bad_request
    end
  end

  def register_info
    device = Device.find_by_name(params[:name])
    render :json => device, :status => :ok
  end

  def receivers
    @devices = Device.where("name <> ?", params[:name])
    render :layout => false, :status => :ok
  end
end
