class Invitation < ActiveRecord::Base

  TYPES = {
    team: "TeamMemberInvitation",
    client: "ClientInvitation"
  }

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :recipient_email, presence: true
  validate :recipient_is_not_registered

  before_create :generate_token

  private

  def self.build_user(type, invitation_token)
    user = type.constantize.new(invitation_token: invitation_token)
    set_invitee_email user
  end

  def self.set_invitee_email(user)
    user.email = user.invitation.recipient_email if user.invitation
    user
  end

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registerd' if User.where(email: recipient_email)
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
