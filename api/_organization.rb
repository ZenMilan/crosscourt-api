module Crosscourt
  module Organization
    class API < Grape::API
      rescue_from :all

      resource :organization do

        desc "Create new organziation"
        params do
          group :organization do
            requires :name, type: String, desc: "Name of organization."
          end
        end
        post do
          # Organization.create!(params[:organization].to_h)
          # { status: 'successfully created project' }
        end

        desc "Update organization"
        params do
          requires :id, type: Integer, desc: "Organization Id."
          requires :name, type: String, desc: "Name of organization."
        end
        put :id do
          # Organization.find(params[:id]).update_attributes
        end

        desc "Destroy organization"
        params do
          requires :id, type: Integer, desc: "Organization Id."
        end
        delete :id do
          # Organization.find(params[:id]).destroy
        end

      end
    end
  end
end
