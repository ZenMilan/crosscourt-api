module Crosscourt
  module GitHub
    class API < Grape::API

      desc "Authenticate with GitHub"
      get 'github/callback' do
        session_code = request.params['code']

        # conn = Faraday.new 'https://github.com'
        binding.pry
        result = Faraday.post('https://github.com/login/oauth/access_token',
          {
            client_id: ENV["GITHUB_CLIENTID"],
            client_secret: ENV["GITHUB_SECRET"],
            code: session_code
          })
        binding.pry
      end

    end
  end
end
