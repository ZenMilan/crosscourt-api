module UserRegistration
  include Virtus.model

  attribute :name, String
  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String

end
