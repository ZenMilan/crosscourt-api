class OrganizationBuilder

  def initialize(params)
    @organization = Organization.create!(params[:org_details].to_h)
    @user = User.find(params[:user_details].id)
  end

  def build!
    build_affiliation(@organization)
  end

  private

  def build_affiliation(organization)
    @user.build_org_affiliation!(organization)
  end

end
