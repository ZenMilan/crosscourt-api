module API
  module Entities
    class User < Grape::Entity
      expose :name, :email
    end
  end
end

module Crosscourt
  module Signup
    class API < Grape::API
      rescue_from :all

      desc "Access to beta account! Fancy!"
      get 'signup/beta/:token' do
        token = ::AccessToken.where(token: params[:token]).first
        error! "invalid token", 401 unless token and token.available?
        { status: 'welcome to beta' }
      end

      desc "Create new account"
      params do
        group :user do
          requires :name, type: String
          requires :email, type: String
          requires :password, type: String
          requires :password_confirmation, type: String
        end
      end
      post 'signup' do
        user = ::User::TYPES[:organization_leader].constantize.create!(params[:user].to_hash)
        warden.set_user(user)
        present :status, 'account created'
        present :current_user, current_user, with: ::API::Entities::User
      end

    end
  end
end
