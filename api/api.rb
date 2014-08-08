module Crosscourt
  class API < Grape::API
    version 'v1', using: :header, vendor: 'crosscourt', strict: true
    prefix 'api'
    format :json
    default_format :json

    use Rack::Session::Cookie, secret: rand.to_s, domain: ".#{ENV['API_DOMAIN']}"

    use Warden::Manager do |manager|
      manager.default_strategies :password
      manager.failure_app = Warden::AuthFailure
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error = e.as_json.first
      Rack::Response.new({
        name: error.first,
        label: error.first.scan(/[^\[\]]+/i).last.humanize,
        msg: error.last
      }.to_json, e.status)
    end

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
