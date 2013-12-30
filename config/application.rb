$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Load up bundled environment via Gemfile
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

# Load environment variables
Dotenv.load if defined?(Dotenv)

# Require files
Dir[File.expand_path('../initializers/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../models/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../models/users/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../models/invitations/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../api/*.rb', __FILE__)].each { |f| require f }

Db::Connect.new
