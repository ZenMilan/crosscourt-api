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
      fail!('Incorrect credentials')
    end
  end
end
