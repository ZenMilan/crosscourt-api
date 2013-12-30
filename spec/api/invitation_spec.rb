require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Invitations' do

    describe 'POST/api/invite/member' do

      context 'with valid parameters' do
        it 'creates an invitation to join organization' do
          org = Organization.create!(name: "Test Org")
          invitation_params = { invitation: { recipient_email: "test@aol.com", organization_id: org.id } }

          post "/api/invite/member", invitation_params
          # expect(last_response.body).to eq({ status: 'something' }.to_json)
          puts last_response.body
        end
      end

    end
  end
end
