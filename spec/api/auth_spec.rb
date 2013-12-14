require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Authentication' do
    describe 'POST /api/login' do

      before(:all) do
        User.create(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password123', password_confirmation: 'password123')
      end

      after(:all) do
        User.delete_all
      end

      context 'with correct credentials' do
        it 'logs in user' do
          post '/api/login', { email: 'pruett.kevin@gmail.com', password: 'password123' }
          expect(last_response.body).to eq({ status: 'Logged in' }.to_json)
        end
      end

      context 'with incorrect credentials' do
        context 'with correct email but incorrect password' do
          it 'reports invalid credentials' do
            post '/api/login', { email: 'pruett.kevin@gmail.com', password: 'password1234' }
            expect(last_response.body).to eq({ error: 'Invalid email or password' }.to_json)
          end
        end
        context 'with incorrect email and correct password' do
          it 'reports invalid credentials' do
            post '/api/login', { email: 'pruettt.kevin@gmail.com', password: 'password123' }
            expect(last_response.body).to eq({ error: 'Invalid email or password' }.to_json)
          end
        end
      end

    end

  end

end
