class Registration
  include UserRegistration, OrganizationRegistration, PaymentRegistration

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    # check params here
    user = User::TYPES[:organization_leader].constantize.create!(things)
    organization = Organization.create!(things)
    payment = Payment.create!(things)
    affiliation = Affiliation.create!(things)

    { user: user, organization: organization, payment: payment, affiliation: affiliation }
  end

end
