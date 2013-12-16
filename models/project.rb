class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :features
  has_one :proposal

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :purpose, presence: true
end
