module Crosscourt
  module Authentication
    class API < Grape::API

      use Rack::Session::Cookie, secret: 'smokey'

      use Warden::Manager do |manager|
        manager.default_strategies :password
        manager.failure_app = Crosscourt::API
      end

      post 'login' do
        env['warden'].authenticate(:password)
        error! "Invalid email or password", 401 unless env['warden'].user
        { status: 'ok' }
      end

      delete 'logout' do
        env['warden'].authenticate
        error! "Unable to log out", 401 unless env['warden'].user
        env['warden'].logout
        { status: "ok" }
      end

    end
  end
end
