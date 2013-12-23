require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Authentication' do

    describe 'GET /api/signup/beta/:token' do
      before(:all) do
        AccessToken.generate_token
      end

      def token
        AccessToken.last
      end

      context 'with valid token' do
        it 'allows access to beta signup' do
          get "/api/signup/beta/#{token.token}"
          expect(last_response.body).to eq({ status: 'welcome to beta' }.to_json)
        end
      end

      context 'with invalid token' do
        it 'does not allow me access to beta signup' do
          get '/api/signup/beta/123abc'
          expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
        end
      end

      context 'with used token' do
        it 'does not allow me access to beta signup' do
          token.update_column('available', false)
          get "/api/signup/beta/#{token.token}"
          expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
        end
      end
    end

    describe 'POST /api/signup' do
      include_context 'create new user'

      context 'with all required parameters' do
        it 'successfully creates an account' do
          user = { user: { name: "Kevin Pruett2", email: "pruett.kevin2@gmail.com", password: "smokey2", password_confirmation: "smokey2" } }
          post '/api/signup', user
          expect(JSON.parse(last_response.body)['current_user']['email']).to eq('pruett.kevin2@gmail.com')
        end
      end

      context 'without an email' do
        it 'fails to create new account' do
          user = { user: { name: "Kevin Pruett", password: "smokey", password_confirmation: "smokey" } }
          post '/api/signup', user
          expect(last_response.body).to eq({ error: 'user[email] is missing' }.to_json)
        end
      end

      context 'account using email already in use' do
        it 'fails to create new account' do
          user = { user: { name: "Kevin Pruett", email: "pruett.kevin@gmail.com", password: "smokey", password_confirmation: "smokey" } }
          post '/api/signup', user
          expect(last_response.body).to eq({ error: 'Validation failed: Email has already been taken' }.to_json)
        end
      end

    end

    describe 'POST /api/login' do
      include_context 'create new user'

      context 'with correct credentials' do
        it 'logs in user' do
          login_user email: 'pruett.kevin@gmail.com', password: 'password123'
          expect(last_response.body).to eq({ status: 'logged in' }.to_json)
        end
      end

      context 'with incorrect credentials' do

        context 'with correct email but incorrect password' do
          it 'reports invalid credentials' do
            login_user email: 'pruett.kevin@gmail.com', password: 'password1234'
            expect(last_response.body).to eq({ error: 'invalid login credentials' }.to_json)
          end
        end

        context 'with incorrect email and correct password' do
          it 'reports invalid credentials' do
            login_user email: 'pruettt.kevin@gmail.com', password: 'password123'
            expect(last_response.body).to eq({ error: 'invalid login credentials' }.to_json)
          end
        end

      end
    end

    describe 'DELETE /api/logout' do
      include_context "create new user"

      context 'when logged in' do
        it 'successfully logs me out' do
          login_user email: 'pruett.kevin@gmail.com', password: 'password123'
          delete  '/api/logout'
          expect(last_response.body).to eq({ status: 'logged out' }.to_json)
        end
      end

      context 'when not logged in' do
        it 'should output an error' do
          delete '/api/logout'
          expect(last_response.body).to eq({ error: 'invalid request' }.to_json)
        end
      end

    end

    describe 'GET /api/current_user' do
      include_context "create new user"

      context 'when logged in' do
        it 'outputs current user info' do
          login_user email: 'pruett.kevin@gmail.com', password: 'password123'
          get '/api/current_user'
          expect(JSON.parse(last_response.body)['email']).to eq('pruett.kevin@gmail.com')
        end
      end

      context 'when not logged in' do
        it 'fails to present current user info' do
          get '/api/current_user'
          expect(last_response.body).to eq({ error: 'cannot retrieve current user' }.to_json)
        end
      end

    end

  end
end
