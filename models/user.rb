class User < ActiveRecord::Base
  has_many :affiliations
  has_many :organizations, through: :affiliations

  has_secure_password

  validates :email, uniqueness: true
end
