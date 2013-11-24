require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe "GET /api/ping" do
    it "returns a friendly pong" do
      get "/api/ping"
      expect do
        last_response.status.should == 200
        last_response.body.should == { :answer => "pong" }.to_json
      end
    end
  end

end