module API
  module Entities
    class Organization < Grape::Entity
      expose :name, :email
    end
  end
end

module Crosscourt
  module Organization
    class API < Grape::API
      rescue_from :all

      desc "New account creates an organization"
      group :organization do
        requires :name, type: String
      end
      get 'signup/organization/new' do
        token = ::AccessToken.where(token: params[:token]).first
        error! "invalid token", 401 unless token and token.available?
        { status: 'welcome to beta' }
      end

    end
  end
end
