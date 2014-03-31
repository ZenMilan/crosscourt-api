module Crosscourt
  module Registration
    class API < Grape::API

      desc "Gain access to fancy beta account!"
      get 'registration/beta/:token' do
        token = ::AccessToken.where(token: params[:token]).first
        error! "invalid token", 401 unless token and token.available?

        present :message, 'welcome to beta'
      end

      desc "Register new account"
      params do
        group :registration do
          group :user do
            requires :name, type: String, non_blank: true
            requires :email, type: String, non_blank: true
            requires :password, type: String, non_blank: true
            requires :password_confirmation, type: String, non_blank: true
          end
          group :organization do
            requires :name, type: String, non_blank: true
          end
          group :payment do
            requires :payment_details, type: String, non_blank: true
          end
        end
      end
      post 'register' do
        registration = ::Registration.new(params[:registration]).register!
        env['warden'].set_user(registration[:user])

        present :message, 'account registered'
        present :current_user, env['warden'].user, with: ::API::Entities::User
      end

    end
  end
end
