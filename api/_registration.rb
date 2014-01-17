module API
  module Entities
    class User < Grape::Entity
      expose :name, :email
    end
  end
end

module Crosscourt
  module Registration
    class API < Grape::API
      rescue_from :all

      desc "Access to beta account! Fancy!"
      get 'registration/beta/:token' do
        token = ::AccessToken.where(token: params[:token]).first
        error! "invalid token", 401 unless token and token.available?
        { message: 'welcome to beta' }
      end

      desc "Register new account"
      params do
        group :registration do
          group :user do
            requires :name, type: String
            requires :email, type: String
            requires :password, type: String
            requires :password_confirmation, type: String
          end
          group :organization do
            requires :name, type: String
          end
          group :payment do
            requires :payment_details, type: String
          end
        end
      end
      post 'register' do
        ::Registration.new.register(params[:registration])

        warden.set_user(User.last)
        present :message, 'account registered'
        present :current_user, current_user, with: ::API::Entities::User
      end

    end
  end
end
