module API
  module Entities
    class User < Grape::Entity
      expose :id, :name, :email
    end

    class Invitation < Grape::Entity
      expose :type, :recipient_email, :organization_id, :project_id, :sender_id
    end
  end
end
