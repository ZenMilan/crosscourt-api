class User < ActiveRecord::Base
  TYPES = {
    organization_leader: 'OrganizationLeader',
    organization_member: 'OrganizationMember',
    client: 'Client'
  }

  # A user can be a member of mulitple organizations
  has_many :organization_affiliations
  has_many :organizations, through: :organization_affiliations

  # A user can be a client on multiple projects
  has_many :project_affiliations
  has_many :projects, through: :project_affiliations

  has_secure_password
end
