module Crosscourt
  module Project
    class API < Grape::API
      rescue_from :all

      desc "Create a new project"
      params do
        group :project do
          requires :name, type: String
          requires :purpose, type: String
          requires :organization_id, type: Integer
        end
      end
      post 'project' do
        # need to get organization from current user
        project = ::Project.create!(params[:project].to_hash)
        { status: 'successfully created project' }
      end

    end
  end
end
