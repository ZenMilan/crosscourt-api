module Crosscourt
  class API < Grape::API

    version 'beta', using: :header, vendor: "crosscourt"
    prefix 'api'
    format :json
    default_format :json

    mount Crosscourt::Status::API
    mount Crosscourt::User::API

  end
end

puts Crosscourt::API.routes
