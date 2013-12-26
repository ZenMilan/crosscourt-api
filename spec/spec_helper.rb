ENV["RACK_ENV"] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

# Authentication Helpers
shared_context "create new user" do
  before(:all) do
    User.create(name: "kevin", email: 'pruett.kevin@gmail.com', password: 'password123', password_confirmation: 'password123')
  end

  after(:all) do
    User.destroy_all
  end

  def login_user(user)
    post '/api/login', user
  end
end
