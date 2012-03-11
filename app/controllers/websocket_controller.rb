class WebsocketController < ApplicationController
  def send_url
    Message.new.send_url params
    render :nothing => true, :status => '200'
  end
end
