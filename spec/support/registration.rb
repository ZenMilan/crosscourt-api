shared_context "with existing account" do
  before(:all) do
    User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password', password_confirmation: 'password')
  end

  after(:all) do
    User.delete_all
  end
end
