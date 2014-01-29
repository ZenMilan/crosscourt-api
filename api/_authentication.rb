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
        p env['warden'].user
        # present :message, 'successfully logged in'
      end

      desc "Logout"
      delete 'logout' do
        env['warden'].logout
        { message: "successfully logged out" }
      end

      desc "Fetch current user"
      get 'current_user' do
        p env['warden'].user
        # error! "cannot retrieve current user", 401 unless current_user
        # current_user
      end

    end
  end
end
