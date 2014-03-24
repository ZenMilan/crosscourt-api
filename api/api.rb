module Crosscourt
  class AuthFailure
    def self.call(env)
      message = env['warden'].message.present? ? env['warden'].message : env['warden.options'][:error]

      [401, {'Content-Type' => 'application/json'}, [{error: message}.to_json]]
    end
  end

  class API < Grape::API
    version 'beta', using: :header, vendor: 'crosscourt'
    prefix 'api'
    format :json
    default_format :json
    content_type :json, "application/json; charset=utf-8"

    use Rack::Session::Cookie, secret: rand.to_s()

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = Crosscourt::AuthFailure
    end

    mount Crosscourt::Status::API
    mount Crosscourt::Registration::API
    mount Crosscourt::Authentication::API
    mount Crosscourt::Invitation::API
    mount Crosscourt::Project::API
    mount Crosscourt::Organization::API
    mount Crosscourt::GitHub::API
  end
end
