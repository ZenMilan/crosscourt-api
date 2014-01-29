module Crosscourt
  class API < Grape::API
    version 'beta', using: :header, vendor: 'crosscourt'
    prefix 'api'
    format :json
    default_format :json

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
        warden.logout
      end
    end

    mount Crosscourt::Status::API
    mount Crosscourt::Registration::API
    mount Crosscourt::Authentication::API
    # mount Crosscourt::Organization::API
    mount Crosscourt::Invitation::API
    mount Crosscourt::Project::API
  end
end
