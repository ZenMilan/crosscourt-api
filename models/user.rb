class User < ActiveRecord::Base
  has_many :payments
  has_many :affiliations
  has_many :organizations, through: :affiliations

  has_secure_password

  validates :email, uniqueness: true

  TYPES = {
    organization_leader: "OrganizationLeader",
    organization_member: "OrganizationMember",
    client: "Client"
  }
end
