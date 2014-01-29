class NonBlank < Grape::Validations::Validator
  def validate_param!(attr_name, params)
    if params[attr_name].blank?
      name = attr_name.to_s.humanize
      raise Grape::Exceptions::Validation, param: name, message: "was left blank"
    end
  end
end

module API
  module Entities
    class User < Grape::Entity
      expose :id, :name, :email
    end
  end
end

module Crosscourt
  module Registration
    class API < Grape::API
      rescue_from :all
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        Rack::Response.new({
          error: e.message.split(',')[0]
        }.to_json, e.status)
      end

      desc "Access to beta account! Fancy!"
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
        registration = ::Registration.new.register!(params[:registration])
        env['warden'].set_user(registration[:user])

        present :message, 'account registered'
        present :current_user, env['warden'].user, with: ::API::Entities::User
      end
    end
  end
end
