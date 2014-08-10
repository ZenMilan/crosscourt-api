module Crosscourt
  module GitHub
    class API < Grape::API
      desc 'GitHub Authentication Callback'
      get 'github/callback' do
        session_code = request.params['code']

        conn = Faraday.new(url: 'https://github.com') do |faraday|
          faraday.request :url_encoded
          faraday.response :json, content_type: /\bjson$/
          faraday.adapter Faraday.default_adapter
        end

        result = conn.post('/login/oauth/access_token',
          {
            client_id:     ENV['GITHUB_CLIENTID'],
            client_secret: ENV['GITHUB_SECRET'],
            code:          session_code
          }, 'Accept' => 'application/json'
        )

        gh_auth = ::GitHubAuthenticator.new(1, result.body)
        result = gh_auth.authenticate!

        status, msg = result.flatten
        # handle redirect here, if success else redirect elsewhere
        redirect "#{ENV['REDIRECT_URI']}?status=#{status}&message=#{msg}"
      end
    end
  end
end
