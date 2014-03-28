module Crosscourt
  module Project
    class API < Grape::API
      rescue_from :all

      resource :project do
        desc "Create a new project"
        params do
          group :project do
            requires :name, type: String, desc: "Name of project."
            requires :purpose, type: String, desc: "Purpose of project."
            requires :organization_id, type: Integer, desc: "Id of organization."
          end
        end
        post do
          project = ::Project.create!(params[:project].to_hash)
          { status: 'successfully created project' }
        end
      end

    end
  end
end
