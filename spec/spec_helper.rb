ENV['RACK_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

Dir[File.expand_path('../support/*.rb', __FILE__)].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.order = :random
  config.mock_with :rspec
  config.expect_with :rspec

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
