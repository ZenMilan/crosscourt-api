require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organization' do

    describe 'POST /api/signup/organization' do
      include_context "with existing account"

      context 'with proper parameters' do
        let(:org_params) { { organization: { name: 'Acme Org' } } }

        it 'creates an organization for a new account' do
          login_account email: 'pruett.kevin@gmail.com', password: 'password123'

          post "/api/signup/organization", org_params

          expect(last_response.body).to eq({ status: 'successfully created affiliation' }.to_json)
          expect(User.find(Affiliation.last.user_id).email).to eq 'pruett.kevin@gmail.com'
          expect(Organization.find(Affiliation.last.organization_id).name).to eq 'Acme Org'
        end
      end

      context 'with invalid parameters' do
        let(:org_params) { { organization: { name: '' } } }

        it 'fails to create an organization' do
          login_account email: 'pruett.kevin@gmail.com', password: 'password123'

          post "/api/signup/organization", org_params

          expect(last_response.body).to eq({ error: "Validation failed: Name can't be blank" }.to_json)
          expect(Organization.count).to eq 0
        end
      end

    end

    describe '#members' do
      it 'lists members of an organization' do

        (1..5).each do |num|

          User::TYPES[:organization_member].constantize.create!(
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
