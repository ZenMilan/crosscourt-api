class User < ActiveRecord::Base
  has_many :affiliations
  has_many :organizations, through: :affiliations

  validates :email, uniqueness: true, presence: true

  has_secure_password

  TYPES = {
    organization_leader: "OrganizationLeader",
    organization_member: "OrganizationMember",
    client: "Client"
  }
end
