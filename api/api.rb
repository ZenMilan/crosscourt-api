module Crosscourt
  class API < Grape::API

    version 'beta', using: :header, vendor: "crosscourt"
    prefix 'api'
    format :json
    default_format :json

    desc "Simple uptime check"
    get :ping do
      { response: 'pong' }
    end

  end
end