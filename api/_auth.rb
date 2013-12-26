module API
  module Entities
    class User < Grape::Entity
      expose :name, :email
    end
  end
end

module Crosscourt
  module Authentication
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
        user = ::User.create!(params[:user].to_hash)
        error! "unable to create account", 401 unless user
        warden.set_user(user)
        present :status, 'account created'
        present :current_user, current_user, with: ::API::Entities::User
      end

      desc "Login to account"
      post 'login' do
        authenticate!
        error! "invalid login credentials", 401 unless current_user
        { status: 'logged in' }
      end

      desc "Logout of account"
      delete 'logout' do
        authenticate!
        error! "invalid request", 401 unless current_user
        logout!
        { status: "logged out" }
      end

      desc "Check session's current user"
      get 'current_user' do
        authenticate!
        error! "cannot retrieve current user", 401 unless current_user
        current_user
      end

    end
  end
end
