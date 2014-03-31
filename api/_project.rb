module Crosscourt
  module Project
    class API < Grape::API

      desc "Create new project"
      params do
        # group :project do
        #   requires :name, type: String, non_blank: true, desc: "Name of organization."
        #   end
        # end
      end
      post '/organizations/:id/projects' do
        # ::OrganizationBuilder.new(params[:organization]).build!
        # { message: "successfully created #{params[:organization][:org_details].name}" }
      end

      desc "Update project"
      params do
        # group :organization do
        #   optional :name, type: String, non_blank: true, desc: "Name of organization"
        end
      end
      patch 'organizations/:id/project/:id' do
        #  ::Organization.find(params[:id]).update!(params[:organization].to_h)
        # { message: "successfully updated organization" }
      end

      desc "Destroy organization"
      params do
        # requires :id, type: Integer, desc: "Organization Id."
      end
      delete 'organizations/:id/projects/:id' do
        # ::Organization.find(params[:id]).destroy!
        # { message: "organization removed" }
      end

    end
  end
end
