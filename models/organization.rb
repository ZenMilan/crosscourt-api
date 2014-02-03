class Organization < ActiveRecord::Base
  # A member can be affiliated with multiple organizations
  has_many :organizational_affiliations
  has_many :members, through: :organization_affiliations, class_name: 'User'

  has_one :payment
  has_many :projects

  validates :name, presence: true

  def owner
    User.find(payment.user_id)
  end
end
