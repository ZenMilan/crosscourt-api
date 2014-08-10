module Crosscourt
  module Authentication
    class API < Grape::API
      desc 'Omniauth Callback'
      get '/auth/:provider/callback' do
        binding.pry
      end
    end
  end
end
