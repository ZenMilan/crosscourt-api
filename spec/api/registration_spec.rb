require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Registration' do

    describe 'GET /api/registration/beta/:token' do
      before(:all) do
        AccessToken.generate_token
      end

      after(:all) do
        AccessToken.destroy_all
      end

      let(:token) { AccessToken.last }

      context 'with valid token' do
        it 'allows access to beta registration' do
          get "/api/registration/beta/#{token.token}"
          expect(last_response.body).to eq({ message: 'welcome to beta' }.to_json)
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

    describe 'POST /api/register' do

      context 'with all required parameters' do
        it 'successfully creates an account', registration: true do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "password" },
              organization: { name: "Registration Organization!" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(JSON.parse(last_response.body)['current_user']['email']).to eq('pruett.kevin@gmail.com')
        end
      end

      context 'without an email' do
        it 'fails to create new account' do
          user = { user: { name: "Kevin Pruett", password: "smokey", password_confirmation: "smokey" } }
          post '/api/signup', user
          expect(last_response.body).to eq({ error: 'user[email] is missing' }.to_json)
        end
      end

      context 'where another account has been created' do
        include_context "with existing account"

        context 'using credentials that already exist' do
          it 'fails to create new account' do
            user_params = { user: { name: "Kevin Pruett", email: "pruett.kevin@gmail.com", password: "smokey", password_confirmation: "smokey" } }
            post '/api/signup', user_params
            expect(last_response.body).to eq({ error: 'Validation failed: Email has already been taken' }.to_json)
          end
        end
      end

    end
  end
end
