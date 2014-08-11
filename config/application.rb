$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

Dotenv.load if defined?(Dotenv)

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../app/models/registration/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../app/models/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../app/entities/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../app/middleware/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../../app/api/*.rb', __FILE__)].each { |f| require f }

require 'api'
require 'app'

Db::Connect.new

I18n.enforce_available_locales = false
