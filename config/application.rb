$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

Dotenv.load if defined?(Dotenv)

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../models/registration/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../models/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../api/*.rb', __FILE__)].each { |f| require f }

Db::Connect.new
