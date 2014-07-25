module Crosscourt
  module Rspec
    module RequestHelpers
      def post!(route:, params:, headers: { 'HTTP_ACCEPT' => 'application/vnd.crosscourt-v1+json' })
        post route, params, headers
      end
    end
  end
end
