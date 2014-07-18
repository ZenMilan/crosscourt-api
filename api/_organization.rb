module Crosscourt
  module Organization
    class API < Grape::API
      desc 'Retrieve organization'
      get 'organization/:name' do
        organization = ::Organization.where(name: params[:name]).first
        present :organization, organization, with: ::API::Entities::Organization
      end
    end
  end
end
