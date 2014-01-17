class Registration

  def register(params)
    user = User::TYPES[:organization_leader].constantize.create!(params[:user].to_h)

    organization = Organization.create!(params[:organization].to_h)

    payment = Payment.create!({ user_id: user.id, organization_id: organization.id }.merge(params[:payment].to_h))

    affiliation = Affiliation.create!({ user_id: user.id, organization_id: organization.id })

    true
  end

end
