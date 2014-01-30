module Crosscourt
  module Invitation
    class API < Grape::API
      rescue_from :all
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        Rack::Response.new({
          error: e.message.split(',')[0]
        }.to_json, e.status)
      end

      helpers do
        def create_invitation(params)
          invitation = ::Invitation::TYPES[:member].constantize.new(params.to_hash)
          invitation.sender = env['warden'].user
          invitation.save
          invitation
        end

        def check_affiliation(invitation_params)
          ::Affiliation.where(user_id: invitee(invitation_params[:recipient_email]).try(:id), organization_id: invitation_params[:organization_id])
        end

        def invitee(email)
          ::User.where(email: email).first
        end

        def parse_invitation(token)
          invitation = ::Invitation.where(token: token).first
        end
      end

      desc "Send invitation to join organization"
      params do
        group :invitation do
          requires :recipient_email, type: String, non_blank: true
          requires :organization_id, non_blank: true
        end
      end
      post 'invite/member' do
        invitation = create_invitation(params[:invitation])

        error! "recipient already a member", 401 unless check_affiliation(params[:invitation]).blank?

        present :message, 'invitation created'
        present :invitation, invitation, with: ::API::Entities::Invitation
      end

      desc "Invite client to join project"
      params do
        group :invitation do
          requires :recipient_email, type: String
          requires :project_id, non_blank: true
        end
      end
      post 'invite/client' do
        # logic for creating client invitation
      end

      desc "Redeem invitation"
      get 'invitation/redeem/:token' do
        invitation = parse_invitation(params[:token])

        error! "invalid invitation token", 401 if parse_invitation(params[:token]).blank?

        present :invitation, invitation, with: ::API::Entities::Invitation
      end

    end
  end
end
