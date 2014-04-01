module Crosscourt
  module Organization
    class API < Grape::API

      desc "Create new organziation"
      params do
        group :organization do
          group :org_details do
            requires :name, type: String, non_blank: true, desc: "Name of organization."
          end
          group :user_details do
            requires :id, type: Integer, desc: "Current user's id."
          end
        end
      end
      post 'organizations' do
        ::OrganizationBuilder.new(params[:organization]).build!
        { message: "successfully created #{params[:organization][:org_details].name}" }
      end

      desc "Update organization"
      params do
        group :organization do
          optional :name, type: String, non_blank: true, desc: "Name of organization"
        end
      end
      patch 'organization/:id' do
         ::Organization.find(params[:id]).update!(params[:organization].to_h)
        { message: "successfully updated organization" }
      end

      desc "Destroy organization"
      delete 'organization/:id' do
        ::Organization.find(params[:id]).destroy!
        { message: "organization removed" }
      end

    end
  end
end
