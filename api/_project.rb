module Crosscourt
  module Project
    class API < Grape::API

      desc "Show all projects belonging to an organization"
      # params do
      #   group :project do
      #     #
      #   end
      # end
      get 'projects' do
        [{ id: 1, name: "hello", purpose: "sweet" }, { id: 2, name: "goodbye", purpose: "da bes" }]
      end

      desc "Create new project"
      params do
        group :project do
          requires :name, type: String, non_blank: true, desc: "Name of project."
          requires :purpose, type: String, non_blank: true, desc: "Purpose of project"
          requires :organization_id, type: Integer, non_blank: true, desc: "Organization Id"
        end
      end
      post 'projects' do
        ::Project.create!(params[:project].to_h)
        { message: "successfully created #{params[:project][:name]}" }
      end

      desc "Update project"
      params do
        group :project do
          optional :name, type: String, non_blank: true, desc: "Name of project"
          optional :purpose, type: String, non_blank: true, desc: "Purpose of project"
        end
      end
      patch 'project/:id' do
        ::Project.find(params[:id]).update!(params[:project].to_h)
        { message: "successfully updated project" }
      end

      desc "Destroy organization"
      delete 'project/:id' do
        ::Project.find(params[:id]).destroy!
        { message: "project removed" }
      end

    end
  end
end
