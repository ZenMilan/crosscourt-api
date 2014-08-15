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
    end
  end
end
