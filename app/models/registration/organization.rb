module Crosscourt
  module Registration
    class Organization
      include Virtus.model

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attribute :name, String

      validates :name, presence: true

      validate :unique_org_name

      def persisted?
        false
      end

    private

      def unique_org_name
        errors.add(:name, 'has already been taken') unless ::Organization.where(org_name: name.downcase).count == 0
      end
    end
  end
end
