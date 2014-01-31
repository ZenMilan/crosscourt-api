class Organization < ActiveRecord::Base
  has_one :payment
  has_many :affiliations
  has_many :members, through: :affiliations, class_name: 'User'
  has_many :projects

  validates :name, presence: true

  def owner
    User.find(payment.user_id)
  end
end
