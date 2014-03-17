require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Authentication' do

    describe 'POST /api/login' do
      include_context "with existing account"

      context 'with correct credentials' do
        it 'logs in user' do

          post '/api/login', email: 'pruett.kevin@gmail.com', password: 'password'
          expect(last_response.body).to eq({ message: 'successfully logged in' }.to_json)
        end
      end

      context 'with incorrect credentials' do

        context 'with correct email but incorrect password' do
          it 'reports invalid credentials' do

            post '/api/login', email: 'pruett.kevin@gmail.com', password: 'wrongpassword'
            expect(last_response.body).to eq({ error: 'incorrect email or password' }.to_json)
          end
        end

        context 'with incorrect email and correct password' do
          it 'reports invalid credentials' do

          post '/api/login', email: 'pruettt.kevin@gmail.com', password: 'password'
            expect(last_response.body).to eq({ error: 'incorrect email or password' }.to_json)
          end
        end

      end
    end

    describe 'DELETE /api/logout' do

      context 'when logged in' do
        include_context "with logged in user"

        it 'successfully logs me out' do

          delete '/api/logout'
          expect(last_response.body).to eq({ message: 'successfully logged out' }.to_json)
        end
      end

      context 'when not logged in' do

        it 'fails to logout user' do

          delete '/api/logout'
          expect(last_response.body).to eq({ error: 'unauthenticated' }.to_json)
        end
      end

    end

    describe 'GET /api/current_user' do

      context 'when logged in' do
        include_context "with logged in user"

        it 'outputs current user info' do

          get '/api/current_user'
          expect(JSON.parse(last_response.body)['current_user']['email']).to eq('pruett.kevin@gmail.com')
        end
      end

      context 'when not logged in' do
        it 'fails to present current user info' do

          get '/api/current_user'
          expect(last_response.body).to eq({ error: 'unauthenticated' }.to_json)
        end
      end

    end

  end
end
