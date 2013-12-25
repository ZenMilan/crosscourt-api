module API
  module Entities
    class Invitation < Grape::Entity
      expose :name, :email
    end
  end
end

module Crosscourt
  module Invitation
    class API < Grape::API
      rescue_from :all

      desc "Send invitations"
      params do
        group :invitation do
          requires :type, type: String
          requires :recipient, type: String
          # more stuff
        end
      end
      post 'invite' do
        # invite member to

        # token = ::AccessToken.where(token: params[:token]).first
        # error! "invalid token", 401 unless token and token.available?
        # { status: 'welcome to beta' }
      end

    end
  end
end
