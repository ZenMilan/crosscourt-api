module API
  module Entities
    class Invitation < Grape::Entity
      expose :recipient_email, :organization_id
    end
  end
end

module Crosscourt
  module Invitation
    class API < Grape::API
      rescue_from :all

      desc "Invite member to join organization"
      params do
        group :invitation do
          requires :recipient_email, type: String
          requires :organization_id
        end
      end
      post 'invite/member' do
        invitation = ::Invitation::TYPES[:member].constantize.create!(params[:invitation].to_hash)

        present :status, 'invitation created'
        present :invitation, invitation, with: ::API::Entities::Invitation
      end

    end
  end
end
