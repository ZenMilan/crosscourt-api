module Crosscourt

  class API < Grape::API
    # Header/Routing Information
    version 'v1', using: :header, vendor: 'crosscourt', strict: true
    prefix 'api'
    format :json
    default_format :json
    # content_type :json, "application/json; charset=utf-8"

    # Cookie Secret
    use Rack::Session::Cookie, secret: rand.to_s()

    # Warden Initialization
    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = Warden::AuthFailure
    end

    # Error Handling
    rescue_from :all
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      Rack::Response.new({
        error: e.message.split(',')[0]
      }.to_json, e.status)
    end

    # API "Modules"
    mount Crosscourt::Status::API
    mount Crosscourt::Registration::API
    mount Crosscourt::Authentication::API
    mount Crosscourt::Invitation::API
    mount Crosscourt::Project::API
    mount Crosscourt::Organization::API
    mount Crosscourt::Project::API
    mount Crosscourt::GitHub::API
  end
end
