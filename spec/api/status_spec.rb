require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Status Check' do

    describe 'GET /api/ping' do
      it 'returns a friendly pong' do
        get '/api/ping'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq({ response: 'pong' }.to_json)
      end
    end

  end

end
