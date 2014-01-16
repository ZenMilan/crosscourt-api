module PaymentRegistration
  include Virtus.model

  attribute :organization_id, Integer
  attribute :user_id, Integer
  attribute :payment_details, String

end
