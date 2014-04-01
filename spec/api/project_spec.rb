require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Projects' do

    include_context "with logged in user"

    let!(:org) {
      Organization.create!(name: "BestOrg")
    }

    let!(:valid_params) {
      {
        project:
          {
            name: "Project Cool",
            purpose: "teach the chidren",
            organization_id: org.id
          }
      }
    }

    let!(:invalid_params) {
      {
        project:
          {
            name: "",
            purpose: "teach the children",
            organization_id: org.id
          }
      }
    }

    describe 'POST /api/projects' do

      after(:each) do
        Organization.delete_all
        Project.delete_all
      end

      context "with valid params" do
        before(:each) do
          post "/api/projects", valid_params
        end

        it 'successfully creates project' do
          expect(last_response.body).to eq({ message: 'successfully created Project Cool' }.to_json)
        end
        it 'is associated with an organization' do
          expect(Project.last.organization.name).to eq "BestOrg"
        end
      end

      context "with invalid params" do
        before(:each) do
          post "/api/projects", invalid_params
        end

        it "fails to create project" do
          expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
        end
      end
    end

    describe 'PATCH /api/project/:id' do

      before(:each) do
        Project.create!(name: "Baz", purpose: "this is purpose", organization_id: org.id)
      end

      after(:each) do
        Project.delete_all
      end

      it 'returns success message' do
        patch "/api/project/#{Project.last.id}", { project: { name: "Updated" } }

        expect(last_response.body).to eq({ message: 'successfully updated project' }.to_json)
      end

      it 'updates name of project' do
        patch "/api/project/#{Project.last.id}", { project: { name: "Foo" } }

        expect(Project.last.name).to eq("Foo")
      end

      it 'updates purpose of project' do
        patch "/api/project/#{Project.last.id}", { project: { purpose: "this is a much better purpose" } }

        expect(Project.last.purpose).to eq "this is a much better purpose"
      end

      it 'updates BOTH the name AND purpose of project' do
        patch "/api/project/#{Project.last.id}", { project: { name: "Fuzzy", purpose: "he was a bear" } }

        expect(Project.last.name).to eq "Fuzzy"
        expect(Project.last.purpose).to eq "he was a bear"
      end

      it 'fails to update when name is blank' do
        patch "/api/project/#{Project.last.id}", { project: { name: "" } }

        expect(last_response.body).to eq({ error: "Name was left blank" }.to_json)
        expect(last_response.status).to eq 400
      end

    end

    describe 'DELETE /api/organization/:id' do
      before(:each) do
        Project.create!(name: "Tatanka", purpose: "this is purpose", organization_id: org.id)
      end

      after(:each) do
        Organization.delete_all
        Project.delete_all
      end

      it 'successfully deletes project' do
        expect(Organization.count).to eq 1
        expect(Project.count).to eq 1
        expect(Project.last.name).to eq "Tatanka"
        delete "api/project/#{Project.last.id}"
        expect(last_response.body).to eq({ message: "project removed" }.to_json)
        expect(Project.count).to eq 0
      end
    end

  end
end
