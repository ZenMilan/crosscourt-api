module API
  module Entities
    class User < Grape::Entity
      expose :id, :name, :email, :organizations
    end

    class Member < Grape::Entity
      expose :id, :name, :email, :type
    end

    class Organization < Grape::Entity
      expose :id, :name, :projects
      expose :members, using: API::Entities::Member
    end

    class Invitation < Grape::Entity
      expose :type, :recipient_email, :organization_id, :project_id, :sender_id
    end
  end
end
