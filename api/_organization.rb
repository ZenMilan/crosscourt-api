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
      post 'signup/organization/new' do
        org = ::Organization.create!(params[:organization].to_hash)
        ::Affiliation.create!(user_id: current_user.id, organization_id: org.id)
        { status: 'successfully created affiliation' }
      end

    end
  end
end
