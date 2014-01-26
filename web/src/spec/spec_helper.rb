ENV['RACK_ENV'] = 'test'

# Prepare test database
sys = java.lang.System
sys.setProperty "DATABASE_URL", "jdbc:hsqldb:mem:javasinatra"
sys.setProperty "DATABASE_DIALECT", "org.hibernate.dialect.HSQLDialect"
sys.setProperty "DATABASE_DRIVER", "org.hsqldb.jdbcDriver"
sys.setProperty "DATABASE_HBM2DDL", "update"

require 'app'
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  JavaSinatra
end
