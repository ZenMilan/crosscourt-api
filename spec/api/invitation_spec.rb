require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Invitations' do

    describe 'POST/api/invite/member' do

      context 'with valid parameters' do
        let(:org) { Organization.create!(name: "Test Org") }
        let(:invitation_params) { { invitation: { recipient_email: "test@aol.com", organization_id: org.id } } }

        it 'creates an invitation to join organization' do
          post "/api/invite/member", invitation_params
          expect(JSON.parse(last_response.body)['invitation']['recipient_email']).to eq('test@aol.com')
        end

        context 'when recipient is already affiliated' do

          # let!(:affiliation) { Affilition.create! }
          xit 'fails to create invitation' do
          end
        end
      end

    end
  end
end
