require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organization' do

    describe 'GET /api/signup/organization/new' do
      include_context 'create new user'

      it 'creates an organization for a new account' do
        login_user email: 'pruett.kevin@gmail.com', password: 'password123'

        org = { organization: { name: 'Acme Org' } }
        post "/api/signup/organization/new", org
        expect(last_response.body).to eq({ status: 'successfully created affiliation' }.to_json)
        # puts last_response.body
      end
    end


  end
end
