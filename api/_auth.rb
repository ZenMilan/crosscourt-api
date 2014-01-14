module Crosscourt
  module Authentication
    class API < Grape::API

      desc "Login to account"
      post 'login' do
        authenticate!
        error! "invalid login credentials", 401 unless current_user
        { message: 'user successfully logged in' }
      end

      desc "Logout of account"
      delete 'logout' do
        authenticate!
        error! "invalid request", 401 unless current_user
        logout!
        { message: "user successfully logged out" }
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
