class Registration

  def initialize(params)
    @params = params
  end

  def register!
    @user = set_user!
    @organization = create_org!
    create_payment!
    establish_affiliation!

    { user: @user }
  end

  private

  def set_user!
    unless @params[:user].include? :password_confirmation
      password = @params[:user][:password]
      @params[:user][:password_confirmation] = password
    end
    User::TYPES[:organization_leader].constantize.create!(@params[:user].to_h)
  end

  def create_org!
    Organization.create!(@params[:organization].to_h)
  end

  def create_payment!
    Payment.create!({ user_id: @user.id, organization_id: @organization.id }.merge(@params[:payment].to_h))
  end

  def establish_affiliation!
    Affiliation::TYPES[:organization].constantize.create!({ user_id: @user.id, organization_id: @organization.id })
  end

end
