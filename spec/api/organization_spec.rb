require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organizations' do

    describe 'POST /api/organizations' do

      include_context "with logged in user"

      context 'with valid parameters' do

        let!(:organization_params) {
          {
            organization:
              {
                org_details:
                  { name: "Tatanka Bull Corp." },
                user_details:
                  { id: User.last.id }
              }
          }
        }

        before(:each) do
          post "/api/organizations", organization_params
        end

        after(:each) do
          Organization.delete_all
          Affiliation.delete_all
        end

        it 'successfully creates an organization' do
          expect(last_response.body).to eq({ message: 'successfully created Tatanka Bull Corp.' }.to_json)
        end

        it 'adds current user as a member of organization' do
          expect(Organization.last.members).to include(User.last)
        end

      end
    end
  end
end

          # expect(JSON.parse(last_response.body)['message']).to eq 'an invitation was sent to notamemberyet@aol.com to join TestOrg'
          #
          # expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('notamemberyet@aol.com')
          #
          # expect(Invitation.last.sender.email).to eq('pruett.kevin@gmail.com')
