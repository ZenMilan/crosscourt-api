require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Invitations' do

    describe 'POST /api/invite/member' do

      include_context "with organization, project, and members established"

      before(:all) do
        post '/api/login', email: 'pruett.kevin@gmail.com', password: 'password'
      end

      context 'with valid parameters' do

        let(:invitation_params) { { invitation: { recipient_email: "notamemberyet@aol.com", organization_id: Organization.last.id } } }

        it 'properly creates invitation' do

          post "/api/invite/member", invitation_params

          expect(JSON.parse(last_response.body)['message']).to eq 'an invitation was sent to notamemberyet@aol.com to join TestOrg'

          expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('notamemberyet@aol.com')

          expect(Invitation.last.sender.email).to eq('pruett.kevin@gmail.com')
        end
      end

      context 'when recipient is already affiliated' do

        let(:invitation_params) { { invitation: { recipient_email: "alreadyamember@aol.com", organization_id: Organization.last.id } } }

        it 'fails to create invitation' do

          post "api/invite/member", invitation_params

          expect(last_response.body).to eq({ error: 'alreadyamember@aol.com is already a member of TestOrg' }.to_json)
        end
      end

      context 'with incorrect params' do

        context 'without a recipient' do

          let(:invitation_params) { { invitation: { recipient_email: "", organization_id: 2 } } }

          it 'reports error message' do
            post '/api/invite/member', invitation_params

            expect(last_response.body).to eq({ error: 'Recipient email was left blank' }.to_json)
          end
        end

        context 'without an organization id' do

          let(:invitation_params) { { invitation: { recipient_email: "recipient@gmail.com", organization_id: '' } } }

          it 'reports proper error message' do

            post '/api/invite/member', invitation_params

            expect(last_response.body).to eq({ error: 'Organization was left blank' }.to_json)
          end
        end

      end

    end

    describe 'POST /api/invite/client' do

      include_context "with organization, project, and members established"

      before(:all) do
        post '/api/login', email: 'pruett.kevin@gmail.com', password: 'password'
      end

      context 'with valid parameters' do

        let(:invitation_params) { { invitation: { recipient_email: "newclient@aol.com", project_id: Project.last.id } } }

        it 'properly creates invitation' do

          post "/api/invite/client", invitation_params

          expect(JSON.parse(last_response.body)['message']).to eq 'an invitation was sent to newclient@aol.com to join project Team Tatanka'

          expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('newclient@aol.com')

          expect(Invitation.last.sender.email).to eq('pruett.kevin@gmail.com')
        end
      end

      context 'when recipient is already affiliated' do

        let(:invitation_params) { { invitation: { recipient_email: "alreadyaclient@gmail.com", project_id: Project.last.id } } }

        it 'fails to create invitation', check: true do

          post "api/invite/client", invitation_params

          expect(last_response.body).to eq({ error: 'alreadyaclient@gmail.com is already included on project Team Tatanka' }.to_json)
        end
      end

      context 'with incorrect params' do

        context 'without a recipient' do

          let(:invitation_params) { { invitation: { recipient_email: "", project_id: 1 } } }

          it 'reports error message' do
            post '/api/invite/client', invitation_params

            expect(last_response.body).to eq({ error: 'Recipient email was left blank' }.to_json)
          end
        end

        context 'without a project id' do

          let(:invitation_params) { { invitation: { recipient_email: "recipient@gmail.com", project_id: '' } } }

          it 'reports proper error message' do

            post '/api/invite/client', invitation_params

            expect(last_response.body).to eq({ error: 'Project was left blank' }.to_json)
          end
        end

      end

    end

    describe 'GET /api/invitation/redeem/:token' do

      include_context "with organization, project, and members established"

      context 'redeeming member invitation' do

        include_context "with member invitation sent"

        context 'with a legit invite token' do

          it 'displays correct invitation information' do
            get "/api/invitation/redeem/#{Invitation.last.token}"

            expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('testmember@aol.com')
            expect(Organization.find(JSON.parse(last_response.body)['invitation']['organization_id']).name).to eq('TestOrg')
          end
        end

        context 'with an incorrect invite token' do
          it 'displays proper error', redeem: true do
            get "/api/invitation/redeem/wrongabc"

            expect(last_response.body).to eq({ error: 'invalid invitation token'}.to_json)
          end
        end

      end

      context 'redeeming client invitation' do

        include_context "with client invitation sent"

        context 'with a legit invite token' do
          it 'displays correct invitation information' do
            get "/api/invitation/redeem/#{Invitation.last.token}"

            expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('testclient@aol.com')
            expect(Project.find(JSON.parse(last_response.body)['invitation']['project_id']).name).to eq('Team Tatanka')
          end
        end

      end

    end
  end
end
