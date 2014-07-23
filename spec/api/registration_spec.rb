require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Registration' do

    # describe 'GET /api/registration/beta/:token' do
    #   before(:all) do
    #     AccessToken.generate_token
    #   end
    #
    #   after(:all) do
    #     AccessToken.destroy_all
    #   end
    #
    #   let(:token) { AccessToken.last }
    #
    #   context 'with valid token' do
    #     it 'allows access to beta registration' do
    #       get "/api/registration/beta/#{token.token}"
    #       expect(last_response.body).to eq({ message: 'welcome to beta' }.to_json)
    #     end
    #   end
    #
    #   context 'with invalid token' do
    #     it 'does not allow me access to beta signup' do
    #       get '/api/registration/beta/123abc'
    #       expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
    #     end
    #   end
    #
    #   context 'with used token' do
    #     it 'does not allow me access to beta signup' do
    #       token.update_column('available', false)
    #       get "/api/registration/beta/#{token.token}"
    #       expect(last_response.body).to eq({ error: 'invalid token' }.to_json)
    #     end
    #   end
    # end

    describe 'POST /api/register' do

      context 'with correct parameters' do

        let(:registration_params) do
          {
            registration:
            {
              user: { first_name: 'kevin', last_name: 'pruett', email: 'pruett.kevin@gmail.com', password: 'password' },
              organization: { name: 'Registration Organization!' },
              payment: { details: 'VISA' }
            }
          }
        end

        it 'should print success message' do
          post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(JSON.parse(last_response.body)['message']).to eq('account registered')
        end

        it 'should set registrant as current user' do
          post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(JSON.parse(last_response.body)['current_user']['email']).to eq('pruett.kevin@gmail.com')
        end

        it 'should affiliate user with organization' do
          post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(User.find(JSON.parse(last_response.body)['current_user']['id']).organizations.last.name).to eq('Registration Organization!')
        end

        it 'should increment user and organization by 1' do
          post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(User.count).to eq 1
          expect(Organization.count).to eq 1
        end

      end

      context 'with multiple blank credentials' do
        let(:registration_params) do
          {
            registration:
            {
              user: { first_name: '', last_name: 'pruett', email: '', password: 'password' },
              organization: { name: 'Registration Organization!' },
              payment: { details: 'VISA' }
            }
          }
        end

        it 'logs error and fails to register account' do
          post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(last_response.status).to eq 400
          expect(last_response.body).to match(/can't be blank/)
          expect(User.count).to eq 0
        end
      end

      context 'using credentials that already exist' do
        include_context 'with existing account'
        # use fabricator

        let(:registration_params) do
          {
            registration:
            {
              user: { name: 'kevin', email: 'pruett.kevin@gmail.com', password: 'password' },
              organization: { name: 'another org' },
              payment: { details: 'VISA' }
            }
          }
        end

        it 'fails to create new account' do
          post '/api/register', registration_params

          expect(last_response.body).to eq({ error: 'Validation failed: Email has already been taken' }.to_json)
        end
      end
    end
  end
end
