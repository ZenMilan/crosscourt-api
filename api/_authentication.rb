module API
  module Entities
    class User < Grape::Entity
      expose :id, :name, :email
    end
  end
end

module Crosscourt
  module Authentication
    class API < Grape::API

      desc "Login"
      params do
        requires :email
        requires :password
      end
      post 'login' do
        env['warden'].authenticate!
        present :message, 'successfully logged in'
      end

      desc "Logout"
      delete 'logout' do
        throw(:warden, error: 'unauthenticated') unless env['warden'].authenticated?

        env['warden'].logout
        present :message, "successfully logged out"
      end

      desc "Fetch current user"
      get 'current_user' do
        throw(:warden, error: 'unauthenticated') unless env['warden'].authenticated?

        present :current_user, env['warden'].user, with: ::API::Entities::User
      end

    end
  end
end
