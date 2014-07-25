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

shared_context 'invalid attrs' do
  let(:attrs) do
    {
      registration:
      {
        user: Fabricate.attributes_for(:org_leader, first_name: '', last_name: ''),
        organization: Fabricate.attributes_for(:organization),
        payment: Fabricate.attributes_for(:payment)
      }
    }
  end
end
