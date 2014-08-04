class Project < ActiveRecord::Base
  # A client can belong to multiple projects
  # has_many :project_affiliations
  # has_many :clients, through: :project_affiliations, class_name: 'User'

  belongs_to :organization
  # has_many :features
  # has_one :proposal

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :purpose, presence: true
end
