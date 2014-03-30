class OrganizationBuilder
  def initialize(params)
    # @org_params = params[:organization][:org_details]
    # @user = User.find(params[:organization][:user_details].id)
    puts params.to_h
  end

  def build!
    @org = build_org!
    build_affiliation(@org)
  end

  private

  def build_org!
    Organization.create!(@org_params)
  end

  def build_affiliation(org)
    @user.build_org_affiliation!(org)
  end

end
