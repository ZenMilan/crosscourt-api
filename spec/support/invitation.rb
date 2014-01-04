shared_context "with member invitation sent" do
  before(:all) do
    Invitation::TYPES[:member].constantize.create!(recipient_email: "testmember@aol.com", organization_id: Organization.last.id, sender_id: User.last.id)
  end

  after(:all) do
    Invitation.delete_all
  end
end
