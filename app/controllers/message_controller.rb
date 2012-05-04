class MessageController < ApplicationController
  protect_from_forgery :except => [:send_url, :register, :register_info]

  def send_message
    Message.new.send_message params
    render :nothing => true, :status => :ok
  end

end
