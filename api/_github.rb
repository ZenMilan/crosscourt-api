module Crosscourt
  module GitHub
    class API < Grape::API

      desc "GitHub Authentication Callback"
      get 'github/callback' do
        session_code = request.params['code']

        conn = Faraday.new(url: 'https://github.com') do |faraday|
          faraday.request :url_encoded
          faraday.response :json, content_type: /\bjson$/
          faraday.adapter Faraday.default_adapter
        end

        result = conn.post('/login/oauth/access_token',
          {
            client_id: ENV["GITHUB_CLIENTID"],
            client_secret: ENV["GITHUB_SECRET"],
            code: session_code
          },
            { 'Accept' => 'application/json' }
          )

        ::GitHubAuthenticator.new(env['warden'].user.id, result.body)
      end

    end
  end
end
