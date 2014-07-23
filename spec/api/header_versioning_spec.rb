require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'API Header Versioning' do

    it 'accepts proper vendor header' do
      get '/api/ping', {}, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'
      expect(last_response.status).to eq(200)
    end

    it 'denies invalid vendor header' do
      get '/api/ping', {}, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v2+json'
      expect(last_response.status).to eq(404)
    end
  end
end
