module Crosscourt
  module GitHub
    class API < Grape::API

      desc "Authenticate with GitHub"
      get 'github/callback' do
        session_code = request.params['code']

        conn = Faraday.new(url: 'https://github.com') do |conn|
          conn.response :json, content_type: /\bjson$/
        end

        binding.pry

        result = conn.post('/login/oauth/access_token',
          {
            client_id: ENV["GITHUB_CLIENTID"],
            client_secret: ENV["GITHUB_SECRET"],
            code: session_code
          }
        )

        binding.pry
        # result = Faraday.post('https://github.com/login/oauth/access_token',
        #   {
        #     client_id: ENV["GITHUB_CLIENTID"],
        #     client_secret: ENV["GITHUB_SECRET"],
        #     code: session_code
        #   })
      end

    end
  end
end
