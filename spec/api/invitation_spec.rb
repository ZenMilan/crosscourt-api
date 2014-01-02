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

        it 'creates an invitation to join organization' do
          post "/api/invite/member", invitation_params

          expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('test@aol.com')
        end

        it 'properly sets the sender of invitation' do
          login_account email: 'pruett.kevin@gmail.com', password: 'password123'
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

      include_context "with organization established"
      include_context "with member invitation sent"

      it 'displays correct information' do
        get "/api/invitation/reedem/#{invitation.token}"

        expect(JSON.parse(last_response.body)['status']).to eq('ok')
        expect(Organization.find(JSON.parse(last_response.body)['organization_id']).name).to eq('TestOrg')
      end

    end
  end
end
