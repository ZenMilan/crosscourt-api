module Crosscourt
  class API < Grape::API
    version 'beta', using: :header, vendor: 'crosscourt'
    prefix 'api'
    format :json
    default_format :json

    mount Crosscourt::Authentication::API
    mount Crosscourt::Status::API
  end
end
