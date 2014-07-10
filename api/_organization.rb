module Crosscourt
  module Organization
    class API < Grape::API

      desc "Create new organziation"
      params do
        group :organization, type: Hash do
          group :org_details, type: Hash do
            requires :name, type: String
          end
          group :user_details, type: Hash do
            requires :id, type: Integer
          end
        end
      end
      post 'organizations' do
        ::OrganizationBuilder.new(params[:organization]).build!
        { message: "successfully created #{params[:organization][:org_details].name}" }
      end

      desc "Update organization"
      params do
        group :organization, type: Hash do
          optional :name, type: String
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
