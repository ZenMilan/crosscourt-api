require 'spec_helper'

describe Crosscourt::API do
  include Rack::Test::Methods

  def app
    Crosscourt::API
  end

  describe 'API Heartbeat' do
    describe 'GET /api/ping' do
      it 'returns a friendly pong' do
        get '/api/ping'
        # browser = Rack::Test::Session.new(Rack::MockSession.new(Crosscourt::API))
        # browser.get '/api/ping'
        # p browser
        # # p Rack::MockSession.new(Crosscourt::API)
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq({ response: 'pong' }.to_json)
      end
    end
  end
end
