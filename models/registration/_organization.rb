module Crosscourt
  module Registration
    class Organization
      include Virtus.model

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attribute :name, String

      validates :name, presence: true

      validate :unique_name

      def persisted?
        false
      end

    private

      def unique_name
        errors.add(:name, 'has already been taken') unless ::Organization.where(name: name).count == 0
      end
    end
  end
end
