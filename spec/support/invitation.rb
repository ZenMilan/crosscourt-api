shared_context "with organization, project, and members established" do
  before(:each) do
    user = User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password', password_confirmation: 'password')

    org = Organization.create!(name: "TestOrg")

    Affiliation::TYPES[:organization].constantize.create!(user_id: user.id, organization_id: org.id)

    member = User::TYPES[:organization_member].constantize.create!(name: "johnny john", email: "alreadyamember@aol.com", password: 'password', password_confirmation: 'password')

    Affiliation::TYPES[:organization].constantize.create!(user_id: member.id, organization_id: org.id)

    project = Project.create!(name: "Team Tatanka", purpose: "this is the purpose", organization_id: org.id)

    client = User::TYPES[:client].constantize.create!(name: "client richardson", email: "alreadyaclient@gmail.com", password: 'password', password_confirmation: 'password')

    Affiliation::TYPES[:project].constantize.create!(user_id: client.id, project_id: project.id)
  end

  after(:each) do
    User.delete_all
    Organization.delete_all
    Affiliation.delete_all
    Project.delete_all
  end
end

shared_context "with member invitation sent" do
  before(:each) do
    Invitation::TYPES[:member].constantize.create!(recipient_email: "testmember@aol.com", organization_id: Organization.last.id, sender_id: User.last.id)
  end

  after(:each) do
    Invitation.delete_all
  end
end

shared_context "with client invitation sent" do
  before(:each) do
    Invitation::TYPES[:client].constantize.create!(recipient_email: "testclient@aol.com", project_id: Project.last.id, sender_id: User.last.id)
  end

  after(:each) do
    Invitation.delete_all
  end
end
