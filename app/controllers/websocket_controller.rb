class WebsocketController < ApplicationController
  protect_from_forgery :except => ["send_url"]

  def send_url
    Message.new.send_url params
    render :nothing => true, :status => '200'
  end
end
