# module API
#   module Entities
#     class Invitation < Grape::Entity
#       expose :name, :email
#     end
#   end
# end

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
        invitation = ::Invitation::TYPES[:member].constantize.new(params[:invitation].to_hash)
        puts invitation
        # token = ::AccessToken.where(token: params[:token]).first
        # error! "invalid token", 401 unless token and token.available?
        # { status: 'welcome to beta' }
      end

    end
  end
end
