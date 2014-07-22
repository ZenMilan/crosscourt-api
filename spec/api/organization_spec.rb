# require 'spec_helper'
#
# describe Crosscourt::API do
#
#   def app
#     Crosscourt::API
#   end
#
#   describe 'Organizations' do
#
#     # Helpers
#     def create_test_org(name)
#       Organization.create!(name: name)
#       add_affiliation
#     end
#
#     def add_affiliation
#       Affiliation::TYPES[:organization].constantize.create!(user_id: User.last.id, organization_id: Organization.last.id)
#     end
#
#     include_context "with logged in user"
#
#     let!(:valid_params) {
#       {
#         organization:
#           {
#             org_details:
#               { name: "Tatanka Bull Corp." },
#             user_details:
#               { id: User.last.id }
#           }
#       }
#     }
#
#     let!(:invalid_params) {
#       {
#         organization:
#           {
#             org_details:
#               { name: " " },
#             user_details:
#               { id: User.last.id }
#           }
#       }
#     }
#
#     describe OrganizationBuilder do
#
#       subject { OrganizationBuilder.new(Hashie::Mash.new(valid_params[:organization])) }
#
#       it { is_expected.to respond_to(:build!) }
#       it "initialize new organization in an instance variable" do
#         expect(subject.instance_variable_get(:@organization).name).to eq "Tatanka Bull Corp."
#       end
#
#     end
#
#     describe 'POST /api/organizations' do
#       after(:each) do
#         Organization.delete_all
#         Affiliation.delete_all
#       end
#
#       context "with valid params" do
#         before(:each) do
#           post "/api/organizations", valid_params
#         end
#
#         it 'successfully creates an organization' do
#           expect(last_response.body).to eq({ message: 'successfully created Tatanka Bull Corp.' }.to_json)
#         end
#         it 'adds current user as a member of organization' do
#           expect(Organization.last.members).to include(User.last)
#         end
#       end
#
#       context "with invalid params" do
#         before(:each) do
#           post "/api/organizations", invalid_params
#         end
#
#         it "fails to create organization" do
#           expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
#         end
#       end
#     end
#
#     describe 'PATCH /api/organization/:id' do
#
#       before(:each) do
#         create_test_org "Patchy Org"
#       end
#
#       after(:each) do
#         Organization.delete_all
#         Affiliation.delete_all
#       end
#
#       it 'returns success message' do
#         patch "/api/organization/#{Organization.last.id}", { organization: { name: "Foo" } }
#
#         expect(last_response.body).to eq({ message: 'successfully updated organization' }.to_json)
#       end
#
#       it 'updates name of organization' do
#         patch "/api/organization/#{Organization.last.id}", { organization: { name: "Updated Org Homie" } }
#
#         expect(Organization.last.name).to eq("Updated Org Homie")
#       end
#
#       it 'fails to update when name is blank' do
#         patch "/api/organization/#{Organization.last.id}", { organization: { name: "" } }
#
#         expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
#         expect(last_response.status).to eq 400
#       end
#
#     end
#
#     describe 'DELETE /api/organization/:id' do
#       before(:each) do
#         create_test_org "Delete This Org"
#       end
#
#       after(:each) do
#         Organization.delete_all
#         Affiliation.delete_all
#       end
#
#       it 'successfully deletes organization' do
#         expect(Organization.count).to eq 1
#         expect(Organization.last.name).to eq "Delete This Org"
#         delete "api/organization/#{Organization.last.id}"
#         expect(last_response.body).to eq({ message: "organization removed" }.to_json)
#         expect(Organization.count).to eq 0
#       end
#     end
#
#   end
# end
