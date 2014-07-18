module API
  module Entities
    class User < Grape::Entity
      expose :id, :first_name, :last_name, :email, :organizations
    end

    class Organization < Grape::Entity
      expose :id, :name, :members
    end

    class Invitation < Grape::Entity
      expose :type, :recipient_email, :organization_id, :project_id, :sender_id
    end
  end
end
