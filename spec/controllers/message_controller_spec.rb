require 'spec_helper'

describe MessageController do

  describe "GET 'send_message'" do
    it "returns http success" do
      get 'send_message'
      response.should be_success
    end
  end

  describe "GET 'register'" do
    it "returns http success" do
      get 'register'
      response.should be_success
    end
  end

  describe "GET 'register_info'" do
    it "returns http success" do
      get 'register_info'
      response.should be_success
    end
  end

  describe "GET 'receivers'" do
    it "returns http success" do
      get 'receivers'
      response.should be_success
    end
  end

end
