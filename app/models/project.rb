class Project < ActiveRecord::Base
  belongs_to :organization

  validates :name, presence: true, uniqueness: { scope: :organization_id }
  validates :purpose, presence: true
end
