module API
  module Entities
    class Organization < Grape::Entity
      expose :name
    end
  end
end

module Crosscourt
  module Organization
    class API < Grape::API
      rescue_from :all

      desc "New account creates an organization"
      params do
        group :organization do
          requires :name, type: String
        end
      end
      post 'signup/organization' do
        org = ::Organization.create!(params[:organization].to_hash)
        ::Affiliation.create!(user_id: current_user.id, organization_id: org.id)
        { status: 'successfully created affiliation' }
      end

      desc "Switch the context of the current organization"
      post 'organization/switch/:organization_id' do
        org = ::Organization.where(id: params[:organization_id])
        error! 'organization does not exist', 401 unless org
        # add organization to current user
        # present :status, 'switched organization'
        # present :organization, org, with ::API::Entities::Organization
      end

    end
  end
end
