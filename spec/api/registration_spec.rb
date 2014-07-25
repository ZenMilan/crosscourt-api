require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'POST /api/register' do
    context 'with valid parameters' do
      include_context 'valid parameters'

      it 'should print success message' do
        post '/api/register', params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

        expect(JSON.parse(last_response.body)['message']).to eq('account registered')
      end
    end
  end
end
