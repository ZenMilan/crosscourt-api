shared_context "with existing account" do
  before(:all) do
    User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password123', password_confirmation: 'password123')
  end

  after(:all) do
    User.delete_all
  end

  def login_account(user)
    post '/api/login', user
  end
end
