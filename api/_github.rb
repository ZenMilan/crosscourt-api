module Crosscourt
  module GitHub
    class API < Grape::API

      desc "Authenticate with GitHub"
      get 'github/callback' do
        session_code = request.params['code']

        result = Faraday.post('https://github.com/login/oauth/access_token',
          {
            client_id: ENV["GITHUB_CLIENTID"],
            client_secret: ENV["GITHUB_SECRET"],
            code: session_code
          })

        # result = HTTParty.post('https://github.com/login/oauth/access_token',
        #   query: {
        #     client_id: ENV["GITHUB_CLIENTID"],
        #     client_secret: ENV["GITHUB_SECRET"],
        #     code: session_code
        #   }
        # )

        access_token = CGI.parse(result.body)["access_token"].join
        scopes = CGI.parse(result.body)["scope"].join.split(',')

        # if scopes.include? 'repo'

        binding.pry
      end

    end
  end
end
