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
          get '/api/registration/beta/123abc'
          expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
        end
      end

      context 'with used token' do
        it 'does not allow me access to beta signup' do
          token.update_column('available', false)
          get "/api/registration/beta/#{token.token}"
          expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
        end
      end
    end

    describe 'POST /api/register' do

      context 'with all required parameters' do
        it 'successfully creates an account' do

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

          # Message response
          expect(JSON.parse(last_response.body)['message']).to eq('account registered')

          # Current user response
          expect(JSON.parse(last_response.body)['current_user']['email']).to eq('pruett.kevin@gmail.com')

          # User/Organization relationship
          expect(User.find(JSON.parse(last_response.body)['current_user']['id']).organizations.last.name).to eq('Registration Organization!')

          # Organization#owner wiring
          expect(User.find(JSON.parse(last_response.body)['current_user']['id']).organizations.last.owner.name).to eq('kevin')

          # User account created
          expect(User.count).to eq 1
        end
      end

      context 'with multiple blank user credentials' do
        it 'logs first error and fails to register account' do

          registration_params =
          {
            registration:
            {
              user: { name: "  ", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "" },
              organization: { name: "Registration Organization!" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
          expect(User.count).to eq 0
        end
      end

      context 'with blank password confirmation' do
        it 'logs proper error and fails to register account' do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "" },
              organization: { name: "Registration Organization!" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: "Password confirmation was left blank" }.to_json)
          expect(User.count).to eq 0
        end
      end

      context 'when password confirmation does not match' do
        it 'displays proper error and fails to register account' do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "wrongpassword" },
              organization: { name: "Registration Organization!" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: "Validation failed: Password confirmation doesn't match Password" }.to_json)
          expect(User.count).to eq 0
        end
      end

      context 'with blank organization name' do
        it 'logs proper error and fails to register account' do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "password" },
              organization: { name: "" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
          expect(User.count).to eq 0
        end
      end

      context 'with missing user params' do
        it 'identifies first missing param and fails to register account' do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin" },
              organization: { name: "" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: "registration[user][email] is missing" }.to_json)
          expect(User.count).to eq 0
        end
      end

      context 'using credentials that already exist' do
        include_context "with existing account"

        it 'fails to create new account' do

          registration_params =
          {
            registration:
            {
              user: { name: "kevin", email: "pruett.kevin@gmail.com", password: "password", password_confirmation: "password" },
              organization: { name: "another org" },
              payment: { payment_details: "VISA" }
            }
          }

          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: 'Validation failed: Email has already been taken' }.to_json)
        end
      end

    end
  end
end
