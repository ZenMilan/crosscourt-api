require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Invitations' do

    describe 'POST /api/invite/member' do

      context 'with valid parameters' do
        include_context "with existing account"

        let(:org) { Organization.create!(name: "Test Org") }
        let(:invitation_params) { { invitation: { recipient_email: "test@aol.com", organization_id: org.id } } }

        it 'creates an invitation to join organization', invitation: true do

          # Simulate logged in user
          post 'api/login', email: 'pruett.kevin@gmail.com', password: 'password'

          post "/api/invite/member", invitation_params

          # expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('test@aol.com')
          puts last_response.body
        end

        it 'properly sets the sender of invitation' do

          # Simulate login
          post 'api/login', email: 'pruett.kevin@gmail.com', password: 'password'

          post "/api/invite/member", invitation_params
          expect(Invitation.last.sender.email).to eq('pruett.kevin@gmail.com')
        end

        context 'when recipient is already affiliated' do
          include_context "with organization established"

          let(:invitation_params) { { invitation: { recipient_email: "johnboy@aol.com", organization_id: Organization.last.id } } }

          it 'fails to create invitation' do
            post "api/invite/member", invitation_params
            expect(last_response.body).to eq({ error: 'recipient already a member' }.to_json)
          end
        end
      end

      context 'with invalid params' do
        it 'reports failures' do
          post "api/invite/member", {invitation: {recipient_email: 'garbage', wrong: 'wrong'}}
          expect(last_response.body).to eq({ error: 'invitation[organization_id] is missing' }.to_json)
        end
      end

    end

    describe 'GET /api/invitation/redeem/:token' do

      context 'redeeming member invitation' do

        include_context "with organization established"
        include_context "with member invitation sent"

        context 'with a legit invite token' do
          it 'displays correct invitation information' do
            get "/api/invitation/redeem/#{Invitation.last.token}"

            expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('testmember@aol.com')
            expect(Organization.find(JSON.parse(last_response.body)['invitation']['organization_id']).name).to eq('TestOrg')
          end
        end

        context 'with an incorrect invite token' do
          it 'displays proper error' do
            get "/api/invitation/redeem/wrongabc"

            expect(last_response.body).to eq({ error: 'invalid invitation token'}.to_json)
          end
        end

      end

      context 'redeeming client invitation' do

        include_context "with organization established"
        include_context "with client invitation sent"

        context 'with a legit invite token' do
          it 'displays correct invitation information' do
            get "/api/invitation/redeem/#{Invitation.last.token}"

            expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('testclient@aol.com')
            expect(Organization.find(JSON.parse(last_response.body)['invitation']['organization_id']).name).to eq('TestOrg')
          end
        end

      end

    end
  end
end
