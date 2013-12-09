module Crosscourt
  module Authentication
    class API < Grape::API

      use Rack::Session::Cookie, :secret => "secret"

      use Warden::Manager do |manager|
        manager.default_strategies :password
        manager.failure_app = Crosscourt::API
      end

      get 'auth_on' do
        puts request.env['warden']
      end

      get "info" do
        env['warden'].authenticate
        error! "Unauthorized", 401 unless env['warden'].user
        { "username" => env['warden'].user.name }
      end

      post 'login' do
        env['warden'].authenticate(:password)
        error! "Invalid username or password", 401 unless env['warden'].user
        { "email" => env['warden'].user.email }
      end

      post 'logout' do
        env['warden'].authenticate
        error! "Logged out", 401 unless env['warden'].user

        env['warden'].logout
        { "status" => "ok" }
      end

    end
  end
end
