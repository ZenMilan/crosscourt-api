module Crosscourt
  module Authentication
    class API < Grape::API
      desc 'GitHub Omniauth Callback'
      get '/auth/:provider/callback' do
        auth = env['omniauth.auth']

        # env['rack.session'][:name] = auth.info.name
        # env['rack.session'][:email] = auth.info.email
        # env['rack.session'][:uid] = auth.uid
        # env['rack.session'][:token] = auth.credentials.token

        cookies[:gh_user] = {
          name:  auth.info.name,
          email: auth.info.email,
          uid:   auth.uid,
          token: auth.credentials.token
        }

        binding.pry
        
        params = env['omniauth.params']
        redirect "#{ENV['REGISTRATION_REDIRECT']}?message=successful%20authentication" if params['type'] == 'registration'
      end
    end
  end
end
