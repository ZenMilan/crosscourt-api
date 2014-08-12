module Crosscourt
  module Status
    class API < Grape::API
      desc 'Simple uptime check'
      get :ping do
        present :response, 'pong'
      end
    end
  end
end
