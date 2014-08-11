module Crosscourt
  module Status
    class API < Grape::API
      desc 'Simple uptime check'
      get :ping do
        binding.pry
        present :response, 'pong'
      end
    end
  end
end
