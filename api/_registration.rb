module Crosscourt
  module Registration
    class API < Grape::API

      desc "Gain access to exclusive beta account!"
      get 'registration/beta/:token' do
        token = ::AccessToken.where(token: params[:token]).first
        error! "invalid token", 401 unless token and token.available?

        present :message, 'welcome to beta'
      end

      desc "Register new account"
      params do
        group :registration, type: Hash do
          group :user, type: Hash do
            requires :first_name, type: String, non_blank: true
            requires :last_name, type: String, non_blank: true
            requires :email, type: String, non_blank: true
            requires :password, type: String, non_blank: true
          end
          group :organization, type: Hash do
            requires :name, type: String, non_blank: true
          end
          group :payment, type: Hash do
            requires :details, type: String, non_blank: true
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
