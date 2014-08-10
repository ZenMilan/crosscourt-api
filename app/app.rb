module Crosscourt
  class App
    class << self
      def instance
        @instance ||= Rack::Builder.new do
          api = Crosscourt::API

          use Rack::Session::Cookie, secret: rand.to_s

          if ENV['GITHUB_KEY'] && ENV['GITHUB_SECRET']
            api.logger.info 'Enabling Github authentication.'
            use OmniAuth::Strategies::GitHub, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user,repo'
          end

          run api
        end.to_app
      end
    end
  end
end
