Dir[File.expand_path(File.dirname(__FILE__) + "/../jars/**/*.jar")].each { |file| puts "requiring jar: #{file}"; require file }

require "rack/test"

Dir[File.expand_path(File.dirname(__FILE__) + "/../lib/**/*.rb")].each { |file| require file }

#set :environment, :test

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.include Rack::Test::Methods

  config.around(:each) do |example|
    Spring::Transaction.without_result do
      example.run
    end
  end

  config.before(:each) do

  end
end

def app
  JavaSinatra
end

def json
  JSON.parse last_response.body, symbolize_names: true
end

def spring_bean(bean_name)
  ::Sinatra::Spring.spring_bean(bean_name)
end

def customer_repository
  spring_bean("customerRepository")
end

java::lang.System.setProperty("DATABASE_URL", "jdbc:mysql://localhost/java_sinatra_test");
