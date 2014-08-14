module Crosscourt
  module Authentication
    class API < Grape::API
      desc 'GitHub Omniauth Callback'
      get '/auth/:provider/callback' do
        auth = env['omniauth.auth']

        response_params = env['omniauth.params']
        uri_params      = "?name=#{auth.info.name}"\
                          "&uid=#{auth.uid}"\
                          "&token=#{auth.credentials.token}"\

        if response_params['type'] == 'registration'
          redirect "#{ENV['REGISTRATION_REDIRECT']}#{URI.escape(uri_params)}"
        end
      end

      # get '/set_cookie' do
      #   cookies[:foo] = {
      #     value: 'bar',
      #     domain: ENV['COOKIE_DOMAIN']
      #   }
      #
      #   env['rack.session'][:foo] = 'bar'
      #
      #   binding.pry
      #   { message: 'set cookie foo to bar' }
      # end
      #
      # get '/check_cookie' do
      #   env['rack.session'][:init] = true
      #   binding.pry
      #   { message: 'check yo cookies' }
      # end
    end
  end
end
