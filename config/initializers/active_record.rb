module Db
  # Connection to db
  class Connect
    def initialize
      dbconfig = YAML.load(File.open('config/database.yml'))[ENV['RACK_ENV']]

      ActiveRecord::Base.default_timezone = 'Eastern Time (US & Canada)'
      ActiveRecord::Base.establish_connection(dbconfig)
      ActiveRecord::Base.logger = Logger.new(STDERR)
    end

    def self.disconnect!
      ActiveRecord::Base.connection.disconnect!
    end
  end
end
