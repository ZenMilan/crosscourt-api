require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Github Authentication' do

    describe 'GET /api/github/callback' do
      include_context "with logged in user"

      context 'with valid response from Github' do
        include_context "with mock github access token request"

        it 'provides valid access token' do

          # get '/api/github/callback'
          puts "###########################"
          p JSON.parse(stub.post('https://github.com/login/oauth/access_token').body)["access_token"]
          # expect(last_response.body).to eq('hooray!')
        end

        # it 'provides valid permissions to repo' do
        #   pending
        # end

      end

    end

  end

end
