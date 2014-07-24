require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Registration#register!' do
    context 'with valid parameters' do
      include_context 'valid parameters' do

        it 'should create a user' do
          expect { register! }.to change { User.count }.by 1
        end

        it 'should create an organization' do
          expect { register! }.to change { Organization.count }.by 1
        end

        it 'should create a payment' do
          expect { register! }.to change { Payment.count }.by 1
        end

        it 'should return a user' do
          expect(register!).to include(:user)
        end

        it 'should set user as organization leader' do
          register!

          expect(User.last.type).to eq 'OrganizationLeader'
        end

        it 'should set user as organization\'s #owner' do
          register!

          expect(Organization.last.owner.first_name).to eq params[:registration][:user][:first_name]
        end

        it 'should print success message' do
          post '/api/register', params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'

          expect(JSON.parse(last_response.body)['message']).to eq('account registered')
        end
      end
    end

    # context 'with multiple blank credentials' do
    #   let(:registration_params) do
    #     {
    #       registration:
    #       {
    #         user: Fabricate.attributes_for(:org_leader, first_name: '', last_name: ''),
    #         organization: Fabricate.attributes_for(:organization),
    #         payment: Fabricate.attributes_for(:payment)
    #       }
    #     }
    #   end
    #
    #   it 'logs error and fails to register account' do
    #     post '/api/register', registration_params, 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json'
    #
    #     expect(last_response.status).to eq 400
    #     expect(last_response.body).to match(/can't be blank/)
    #   end
    # end
    #
    # context 'using credentials that already exist' do
    #
    #   let(:registration_params) do
    #     {
    #       registration:
    #       {
    #         user: { name: 'kevin', email: 'pruett.kevin@gmail.com', password: 'password' },
    #         organization: { name: 'another org' },
    #         payment: { details: 'VISA' }
    #       }
    #     }
    #   end
    #
    #   it 'fails to create new account' do
    #     post '/api/register', registration_params
    #
    #     expect(last_response.body).to eq({ error: 'Validation failed: Email has already been taken' }.to_json)
    #   end
    # end
  end
end
