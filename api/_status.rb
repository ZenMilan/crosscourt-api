module Crosscourt
  module Status
    # A simple API status check
    class API < Grape::API
      desc 'Simple uptime check'
      get :ping do
        { response: 'pong' }
      end
    end
  end
end
