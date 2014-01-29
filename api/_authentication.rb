module Crosscourt
  module Authentication
    class API < Grape::API

      desc "Login"
      post 'login' do
        # env['warden'].authenticate
        error! "invalid login credentials", 401 unless env['warden'].authenticate
        present :message, 'successfully logged in'
        present :current_user, env['warden'].authenticate
      end

      desc "Logout"
      delete 'logout' do
        env['warden'].logout
        { message: "successfully logged out" }
      end

      desc "Check session's current user"
      get 'current_user' do
        env['warden'].authenticate
        # error! "cannot retrieve current user", 401 unless current_user
        # current_user
      end

    end
  end
end
