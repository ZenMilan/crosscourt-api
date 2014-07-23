require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'API Heartbeat' do

    describe 'GET /api/ping' do
      it 'returns a friendly pong' do
        get '/api/ping', {}, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq({ response: 'pong' }.to_json)
      end
    end
  end
end
