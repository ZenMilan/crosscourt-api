shared_context "with organization established" do
  before(:all) do
    let(:invitation) { Invitation.create!(recipient_email: "testmember@aol.com", organization_id: Organization.last.id, sender_id: User.last.id) }
  end

  after(:all) do
    Invitation.delete_all
  end
end
