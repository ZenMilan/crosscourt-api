require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organization' do

    describe 'POST /api/signup/organization/new' do
      include_context 'create new user'

      it 'creates an organization for a new account' do

        login_user email: 'pruett.kevin@gmail.com', password: 'password123'

        org = { organization: { name: 'Acme Org' } }
        post "/api/signup/organization/new", org

        expect(last_response.body).to eq({ status: 'successfully created affiliation' }.to_json)
        expect(User.find(Affiliation.last.user_id).email).to eq 'pruett.kevin@gmail.com'
        expect(Organization.find(Affiliation.last.organization_id).name).to eq 'Acme Org'
      end
    end

    describe '#members' do
      it 'lists members of an organization' do

        (1..5).each do |num|
          User.create!(
            name: "fullname#{num}",
            email: "email#{num}@gmail.com",
            password: "password#{num}",
            password_confirmation: "password#{num}"
          )
        end

        Organization.create!(name: "Sweet Co Bro")

        (1..5).each do |num|
          Affiliation.create!(user_id: User.where(email: "email#{num}@gmail.com").first.id, organization_id: Organization.last.id)
        end

        expect(Organization.last.members.count).to eq(5)
      end
    end

  end
end
