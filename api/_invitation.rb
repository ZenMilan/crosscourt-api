module Crosscourt
  module Invitation
    class API < Grape::API

      helpers do
        def create_invitation(type, params)
          invitation = ::Invitation::TYPES[type].constantize.new(params.to_hash)
          invitation.sender = env['warden'].user
          invitation.save
          invitation
        end

        def check_affiliation(type, invitation_params)
          case type
          when 'member'
            ::Affiliation.where(user_id: invitee(invitation_params[:recipient_email]).try(:id), organization_id: invitation_params[:organization_id])
          when 'client'
            ::Affiliation.where(user_id: invitee(invitation_params[:recipient_email]).try(:id), project_id: invitation_params[:project_id])
          end
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
        group :invitation, type: Hash do
          requires :recipient_email, type: String
          requires :organization_id
        end
      end
      post 'invite/member' do
        invitation = create_invitation(:member, params[:invitation])

        error! "#{params[:invitation][:recipient_email]} is already a member of #{::Organization.find(params[:invitation][:organization_id]).name}", 401 unless check_affiliation('member', params[:invitation]).blank?

        present :message, "an invitation was sent to #{invitation.recipient_email} to join #{::Organization.find(invitation.organization_id).name}"
        present :invitation, invitation, with: ::API::Entities::Invitation
      end

      desc "Invite client to join project"
      params do
        group :invitation, type: Hash do
          requires :recipient_email, type: String
          requires :project_id
        end
      end
      post 'invite/client' do
        invitation = create_invitation(:client, params[:invitation])

        error! "#{params[:invitation][:recipient_email]} is already included on project #{::Project.find(params[:invitation][:project_id]).name}", 401 unless check_affiliation('client', params[:invitation]).blank?

        present :message, "an invitation was sent to #{params[:invitation][:recipient_email]} to join project #{::Project.find(params[:invitation][:project_id]).name}"
        present :invitation, invitation, with: ::API::Entities::Invitation
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
