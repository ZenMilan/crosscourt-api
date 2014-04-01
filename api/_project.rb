module Crosscourt
  module Project
    class API < Grape::API

      desc "Create new project"
      params do
        group :project do
          requires :name, type: String, non_blank: true, desc: "Name of project."
          requires :purpose, type: String, non_blank: true, desc: "Purpose of project"
          end
        end
      end
      post '/organizations/:id/projects' do
        ::Project.create!(params[:project].to_h)
        { message: "successfully created project #{params[:project][:name]}" }
      end

      desc "Update project"
      params do
        # group :organization do
        #   optional :name, type: String, non_blank: true, desc: "Name of organization"
        end
      end
      patch 'organizations/:org_id/project/:id' do
         ::Project.find(params[:id]).update!(params[:organization].to_h)
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
