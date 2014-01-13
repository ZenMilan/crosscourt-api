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
