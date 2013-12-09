require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Authentication' do
    before(:all) do
      User.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password123', password_confirmation: 'password123')
    end

    after(:all) do
      User.destroy_all
    end

    describe 'POST /api/login' do
      it 'creates a user' do
        post '/api/login', { email: 'pruett.kevin@gmail.com', password: 'smokey' }
        # expect(last_response.body).to eq({ email: 'pruett.kevin@gmail.com' }.to_json)
        puts env['warden']
      end
    end

  end

end
