module Crosscourt
  module Registration
    class Payment
      include Virtus.model

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attribute :details, String

      validates :details, presence: true

      def persisted?
        false
      end
    end
  end
end
