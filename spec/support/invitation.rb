shared_context "with member invitation sent" do
  before(:all) do
    Invitation::TYPES[:member].constantize.create!(recipient_email: "testmember@aol.com", organization_id: Organization.last.id, sender_id: User.last.id)
  end

  after(:all) do
    Invitation.delete_all
  end
end

shared_context "with client invitation sent" do
  before(:all) do
    Invitation::TYPES[:client].constantize.create!(recipient_email: "testclient@aol.com", organization_id: Organization.last.id, sender_id: User.last.id)
  end

  after(:all) do
    Invitation.delete_all
  end
end

shared_context "with organization established" do
  before(:all) do
    user = User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin1@gmail.com', password: 'password123', password_confirmation: 'password123')

    org = Organization.create!(name: "TestOrg")

    Affiliation.create!(user_id: user.id, organization_id: org.id)

    member = User::TYPES[:organization_member].constantize.create!(name: "johnny john", email: "johnboy@aol.com", password: 'password', password_confirmation: 'password')

    Affiliation.create!(user_id: member.id, organization_id: org.id)
  end

  after(:all) do
    User.delete_all
    Organization.delete_all
    Affiliation.delete_all
  end
end
