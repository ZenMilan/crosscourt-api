class Organization < ActiveRecord::Base
  # A member can be affiliated with multiple organizations
  has_many :organization_affiliations
  has_many :members, through: :organization_affiliations, class_name: 'User', source: :user

  has_one :payment, inverse_of: :organization
  has_many :projects

  def cardholder
    members.where(type: 'OrganizationLeader').first
  end

  alias_method :owner, :cardholder
end
