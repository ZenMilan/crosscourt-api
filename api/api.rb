module Crosscourt
  class API < Grape::API

    use Rack::Session::Cookie, :secret => "replace this with some secret key"

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = Crosscourt::API
    end

    version 'beta', using: :header, vendor: "crosscourt"
    prefix 'api'
    format :json
    default_format :json

    desc "Simple uptime check"
    get :ping do
      { response: 'pong' }
    end

    get 'warden' do
      env['warden'].user
    end

    get 'user' do
      Crosscourt::User.get(2).name
    end

    get "info" do
      env['warden'].authenticate
      error! "Unauthorized", 401 unless env['warden'].user
      { "username" => env['warden'].user.name }
    end

    post 'login' do
      env['warden'].authenticate(:password)
      error! "Invalid username or password", 401 unless env['warden'].user
      { "username" => env['warden'].user.name }
    end

    delete 'logout' do
      env['warden'].authenticate
      error! "Logged out", 401 unless env['warden'].user

      env['warden'].logout
      { "status" => "ok" }
    end

  end
end