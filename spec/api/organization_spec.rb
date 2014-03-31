require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Organizations' do

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

      describe OrganizationBuilder do

        subject { OrganizationBuilder.new(Hashie::Mash.new(organization_params[:organization])) }

        it { is_expected.to respond_to(:build!) }

        it "initialize new organization in an instance variable" do
          expect(subject.instance_variable_get(:@organization).name).to eq "Tatanka Bull Corp."
        end

      end

      describe 'POST /api/organizations' do

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
