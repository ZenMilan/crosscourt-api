class Organization < ActiveRecord::Base
  has_one :payment
  has_many :affiliations
  has_many :users, through: :affiliations
  has_many :projects

  alias_attribute :members, :users

  validates :name, presence: true

  def owner
    User.find(payment.user_id)
  end
end
