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

      use Rack::Session::Cookie, secret: 'smokey'

      use Warden::Manager do |manager|
        manager.default_strategies :password
        manager.failure_app = Crosscourt::API
      end

      helpers do
        def warden
          env['warden']
        end

        def current_user
          warden.user
        end

        def authenticate!
          warden.authenticate
        end

        def logout!
          env['warden'].logout
        end
      end

      get 'signup' do
        redirect 'signup/beta'
      end

      get 'signup/beta' do
        { cool: 'not' }
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

      post 'login' do
        authenticate!
        error! "invalid login credentials", 401 unless current_user
        { status: 'logged in' }
      end

      delete 'logout' do
        authenticate!
        error! "invalid request", 401 unless current_user
        logout!
        { status: "logged out" }
      end

      get 'current_user' do
        authenticate!
        error! "cannot retrieve current user", 401 unless current_user
        current_user
      end

    end
  end
end
