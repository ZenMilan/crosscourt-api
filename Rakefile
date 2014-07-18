require 'active_record'

include ActiveRecord::Tasks

db_dir = File.expand_path('../db', __FILE__)
config_dir = File.expand_path('../config', __FILE__)
env = ENV['RACK_ENV'] || 'development'

DatabaseTasks.env = env
DatabaseTasks.db_dir = db_dir
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(config_dir, 'database.yml')))
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env
end

load 'active_record/railties/databases.rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task test: :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

task default: [:spec, :rubocop]

task :wipe_db do
  sh "RAKE_ENV=test rake db:drop db:create db:migrate"
end
