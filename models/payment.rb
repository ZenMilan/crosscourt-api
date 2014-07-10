class Payment < ActiveRecord::Base
  belongs_to :organization
  validates :organization, presence: true
  belongs_to :user
  validates :user, presence: true
end
