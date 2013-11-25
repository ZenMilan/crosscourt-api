$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
Bundler.require(:default)

Dir[File.expand_path('../initializers/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end