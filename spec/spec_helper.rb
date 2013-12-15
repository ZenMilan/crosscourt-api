ENV["RACK_ENV"] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

shared_context "create new user" do
  before(:all) do
    User.create(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password123', password_confirmation: 'password123')
  end

  after(:all) do
    User.delete_all
  end

  def login_user(user)
    post '/api/login', user
  end
end
