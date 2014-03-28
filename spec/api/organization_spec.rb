require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organizations' do

    describe 'POST /api/organization' do

      include_context "with logged in user"

      context 'with valid parameters' do

        let(:organization_params) {
          {
            organization:
              {
                name: "Tatanka Bull Corp.",
                user: { id: User.last.id }
              }
          }
        }

        it 'properly creates an organization' do
          post "/api/organizations", organization_params
          expect(last_response.body).to eq({ message: 'successfully created Tatanka Bull Corp.' }.to_json)
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
