module Crosscourt
  module Authentication
    class API < Grape::API

      desc "Login"
      post 'login' do
        authenticate!
        error! "invalid login credentials", 401 unless current_user
        { message: 'successfully logged in' }
      end

      desc "Logout"
      delete 'logout' do
        # authenticate!
        # {user: current_user}
        error! "invalid request", 401 unless current_user
        logout!
        { message: "successfully logged out" }
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
