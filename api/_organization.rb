module Crosscourt
  module Organization
    class API < Grape::API
      rescue_from :all

      resource :organizations do

        desc "Create new organziation"
        params do
          group :organization do
            requires :name, type: String, desc: "Name of organization."
            group :user do
              requires :id, type: Integer, desc: "Current user's id."
            end
          end
        end
        post do
          # create organization creation first class object
          # ::Organization.create!(params[:organization].to_h)
          { message: 'successfully created #{params[:organization][:name]}' }
        end

        desc "Update organization"
        params do
          group :organization do
            requires :id, type: Integer, desc: "Organization Id."
            optional :name, type: String, desc: "Name of organization"
          end
        end
        patch :id do  Organization.find(params[:organization][:id]).update!(params[:organization].to_h)
        end

        desc "Destroy organization"
        params do
          requires :id, type: Integer, desc: "Organization Id."
        end
        delete :id do
          Organization.find(params[:id]).destroy!
        end

      end
    end
  end
end
