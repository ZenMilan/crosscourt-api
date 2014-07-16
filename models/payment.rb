class Payment < ActiveRecord::Base
  belongs_to :organization, inverse_of: :payment
end
