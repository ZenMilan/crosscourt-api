module Crosscourt
  module Registration
    class API < Grape::API
      # desc 'Gain access to exclusive beta account!'
      # get 'registration/beta/:token' do
      #   token = ::AccessToken.where(token: params[:token]).first
      #   error! 'invalid token', 401 unless token && token.available?
      #
      #   present :message, 'welcome to beta'
      # end

      rescue_from RegistrationErrors::ValidationError do |e|
        error = e.message.humanize
        Rack::Response.new({ error: error }.to_json, 400)
      end

      desc 'Register new account'
      params do
        group :registration, type: Hash do
          group :user, type: Hash do
            requires :first_name, type: String
            requires :last_name, type: String
            requires :email, type: String
            requires :password, type: String
          end
          group :organization, type: Hash do
            requires :name, type: String
          end
          group :payment, type: Hash do
            requires :details, type: String
          end
        end
      end
      post 'register' do
        registration = ::Registration.new(params[:registration]).register!
        env['warden'].set_user(registration[:user])
        binding.pry
        present :message, 'account registered'
        present :current_user, env['warden'].user, with: ::API::Entities::User
      end
    end
  end
end
