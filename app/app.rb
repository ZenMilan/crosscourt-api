module Crosscourt
  class App
    class << self
      def instance # rubocop:disable Metrics/MethodLength
        @instance ||= Rack::Builder.new do
          api = Crosscourt::API

          use Rack::Cors do
            allow do
              origins ENV['CORS_ORIGIN']
              resource '*',
                headers: :any,
                methods: [:get, :post, :put, :delete, :options]
            end
          end

          use Rack::Session::Cookie, secret: rand.to_s

          if ENV['GITHUB_KEY'] && ENV['GITHUB_SECRET']
            api.logger.info 'Enabling Github authentication.'
            use OmniAuth::Strategies::GitHub, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user,repo'
          end

          use ActiveRecord::ConnectionAdapters::ConnectionManagement

          run api
        end.to_app
      end
    end
  end
end
