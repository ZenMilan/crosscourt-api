# # Create New User
# shared_context "with existing account" do
#   before(:each) do
#     User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password', password_confirmation: 'password')
#   end
#
#   after(:each) do
#     User.delete_all
#   end
# end
#
# # Create & Login New User
# shared_context "with logged in user" do
#   before(:each) do
#     User::TYPES[:organization_leader].constantize.create!(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password', password_confirmation: 'password')
#
#     post '/api/login', email: 'pruett.kevin@gmail.com', password: 'password'
#   end
#
#   after(:each) do
#     User.delete_all
#   end
# end
