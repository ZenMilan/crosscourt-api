class Registration

  def register!(params)
    user = User::TYPES[:organization_leader].constantize.create!(params[:user].to_h)

    organization = Organization.create!(params[:organization].to_h)

    Payment.create!({ user_id: user.id, organization_id: organization.id }.merge(params[:payment].to_h))

    Affiliation::TYPES[:organization].constantize.create!({ user_id: user.id, organization_id: organization.id })

    { user: user }
  end

end
