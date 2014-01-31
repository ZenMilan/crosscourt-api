class User < ActiveRecord::Base
  has_many :payments
  has_many :affiliations
  has_many :organizations, through: :affiliations

  # Button this up
  has_many :relationships
  has_many :projects, through: :relationships

  has_secure_password

  validates :email, uniqueness: true

  TYPES = {
    organization_leader: "OrganizationLeader",
    organization_member: "OrganizationMember",
    client: "Client"
  }
end
