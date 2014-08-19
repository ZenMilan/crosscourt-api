module Crosscourt
  module Registration
    class User
      include Virtus.model

      extend ActiveModel::Naming
      include ActiveModel::Conversion
      include ActiveModel::Validations

      attribute :uid, String
      attribute :token, String

      validates :uid, presence: true
      validates :token, presence: true

      validate :unique_uid

      def persisted?
        false
      end

      def construct_via_gh_token!(user)
        gh_client = Octokit::Client.new(access_token: user.token)

        user_attrs = {
          name: gh_client.user.name,
          email: gh_client.user.email
        }

        ::User::TYPES[:organization_leader].constantize.create! user.attributes.merge(user_attrs)
      end

    private

      def unique_uid
        errors.add(:uid, 'has already been registered') unless ::User.where(uid: uid).count == 0
      end
    end
  end
end
