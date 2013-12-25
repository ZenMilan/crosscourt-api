module Crosscourt
  class API < Grape::API
    version 'beta', using: :header, vendor: 'crosscourt'
    prefix 'api'
    format :json
    default_format :json

    mount Crosscourt::Status::API
    mount Crosscourt::Authentication::API
    mount Crosscourt::Invitation::API
  end
end
