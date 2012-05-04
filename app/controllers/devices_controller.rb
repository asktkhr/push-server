class MessageController < ApplicationController
  require 'c2dm'
  require 'net/https'
  require 'uri'
  require 'json'

  protect_from_forgery :except => [:register, :register_info, :delete]

  def register
    device = Device.new
    device.name = params[:name]
    device.registration_id = params[:registration_id] unless params[:registration_id].blank?
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
    respond_to do |format|
      format.html { render :layout => false, :status => :ok }
      format.json { render :json => @devices.to_json, :status => :ok }
    end
  end

  def delete
    Device.find_by_name(params[:name]).delete
  end
end
