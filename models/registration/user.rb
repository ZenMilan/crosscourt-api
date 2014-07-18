module Virtus
  module Registration
    class User
      include Virtus.model

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attribute :first_name, String
      attribute :last_name, String
      attribute :email, String
      attribute :password, String

      validates :first_name, presence: true
      validates :last_name, presence: true
      validates :email, presence: true
      validates :password, presence: true

      validate :unique_email

      def persisted?
        false
      end

    private

      def unique_email
        errors.add(:email, 'has already been taken') unless ::User.where(email: email).count == 0
      end
    end
  end
end
