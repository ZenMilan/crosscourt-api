class User < ActiveRecord::Base
  TYPES = {
    organization_leader: "OrganizationLeader",
    organization_member: "OrganizationMember",
    client: "Client"
  }

  # A user can be a member of mulitple organizations
  has_many :organization_affiliations
  has_many :organizations, through: :organization_affiliations

  # A user can be a client on multiple projects
  has_many :project_affiliations
  has_many :projects, through: :project_affiliations

  has_many :payments, inverse_of: :user

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def gh_client
    @gh_client ||= Octokit::Client.new(access_token: gh_access_token)
  end

  def build_org_affiliation!(org)
    Affiliation::TYPES[:organization].constantize.create!(user_id: id, organization_id: org.id)
  end

end
