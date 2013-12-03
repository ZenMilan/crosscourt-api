require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe "User Endpoints" do

    describe "POST /api/user" do
      it "creates a user" do
        post "/api/user"
        pending
      end
    end

    describe "GET /api/user/:id" do
      it "returns user status" do
        get "/api/user/1"
        pending
      end
    end

  end

end
