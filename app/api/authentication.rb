module Crosscourt
  module Authentication
    class API < Grape::API
      desc 'GitHub Omniauth Callback'
      get '/auth/:provider/callback' do
        auth = env['omniauth.auth']

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

      get '/set_cookie' do
        cookies[:foo] = 'bar'

        { message: 'set cookie foo to bar' }
      end

      get '/check_cookie' do
        binding.pry
        { message: 'check yo cookies' }
      end
    end
  end
end
