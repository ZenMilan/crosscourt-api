Warden::Manager.serialize_into_session { |user| user.id }
Warden::Manager.serialize_from_session { |id| User.find(id) }

Warden::Strategies.add(:password) do

  def valid?
    params['email'] || params['password']
  end

  def authenticate!
    user = User.find_by_email(params['email'])
    if user && user.authenticate(params['password'])
      success!(user)
    else
      fail!('incorrect email or password')
    end
  end

end

module Warden
  class AuthFailure
    def self.call(env)
      message = env['warden'].message.present? ? env['warden'].message : env['warden.options'][:error]

      [401, {'Content-Type' => 'application/json'}, [{error: message}.to_json]]
    end
  end
end
