module Crosscourt
  module Project
    class API < Grape::API
      desc 'Get all projects belonging to organization'
      get 'organization/:name/projects' do
        # TODO
        # Validate user / user's organization
        organization = ::Organization.where(name: params[:name]).first

        error! "Organization #{params[:name]} does not exist", 404 unless organization
        present :projects, organization.projects # , with: ::API::Entities::Organization
      end
      # desc 'Create new project'
      # params do
      #   group :project, type: Hash do
      #     requires :name, type: String
      #     requires :purpose, type: String
      #     requires :organization_id, type: Integer
      #   end
      # end
      # post 'projects' do
      #   ::Project.create!(params[:project].to_h)
      #   { message: "successfully created #{params[:project][:name]}" }
      # end
      #
      # desc 'Update project'
      # params do
      #   group :project, type: Hash do
      #     optional :name, type: String
      #     optional :purpose, type: String
      #   end
      # end
      # patch 'project/:id' do
      #   ::Project.find(params[:id]).update!(params[:project].to_h)
      #   { message: 'successfully updated project' }
      # end
      #
      # desc 'Destroy organization'
      # delete 'project/:id' do
      #   ::Project.find(params[:id]).destroy!
      #   { message: 'project removed' }
      # end
    end
  end
end
