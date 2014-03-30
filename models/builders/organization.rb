class OrganizationBuilder
  
  def initialize(params)
    @org_params = params[:org_details].to_h
    @user = User.find(params[:user_details].id)
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
