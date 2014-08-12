require 'active_record'
require 'rspec/core/rake_task'

include ActiveRecord::Tasks

db_dir = File.expand_path('../app/db', __FILE__)
config_dir = File.expand_path('../config', __FILE__)
env = ENV['RACK_ENV'] || 'development'

DatabaseTasks.env = env
DatabaseTasks.db_dir = db_dir
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(config_dir, 'database.yml')))
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'

RSpec::Core::RakeTask.new(:spec)

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

namespace :setup do
  task :bundle do
    sh 'bundle'
  end
  task :test_db do
    sh 'RAKE_ENV=test rake db:drop db:create db:migrate'
  end
  task :dev_db do
    sh 'rake db:drop db:create db:migrate'
  end
end

task bootstrap: ['setup:bundle', 'setup:test_db', 'setup:dev_db']
task default: [:spec, :rubocop]
