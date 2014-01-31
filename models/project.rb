class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :features
  has_many :client_relationships
  has_many :clients, through: :client_relationships
  has_one :proposal

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :purpose, presence: true
end
