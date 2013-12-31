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

      helpers do
        def check_affiliation(invitation_params)
          ::Affiliation.where(user_id: invitee(invitation_params[:recipient_email]).try(:id), organization_id: invitation_params[:organization_id])
        end

        def invitee(email)
          User.where(email: email).first
        end
      end

      desc "Invite member to join organization"
      params do
        group :invitation do
          requires :recipient_email, type: String
          requires :organization_id
        end
      end
      post 'invite/member' do
        invitation = ::Invitation::TYPES[:member].constantize.create!(params[:invitation].to_hash)

        error! "recipient already a member", 401 unless check_affiliation(params[:invitation]).blank?

        present :status, 'invitation created'
        present :invitation, invitation, with: ::API::Entities::Invitation
      end

    end
  end
end
