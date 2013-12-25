module Crosscourt
  module Status
    class API < Grape::API
      desc 'Simple uptime check'
      get :ping do
        { response: 'pong' }
      end
    end
  end
end
