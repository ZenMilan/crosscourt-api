module Crosscourt
  module Rspec
    module RegistrationHelpers
      def register!(params: nil)
        attributes = params ? params : attrs[:registration]

        ::Registration.new(attributes).register!
      end
    end
  end
end
