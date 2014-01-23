APP_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(APP_ENV)

require 'java'

require 'sinatra/base'
require 'sinatra/reloader'

require 'sinatra_spring'



java_import 'javasinatra.core.model.Customer'

c = Customer.new;
c.name = "Some Customer"
c.email = "some_customer@domain.com"

include Sinatra::Spring
bean("customerRepository").save(c)

class JavaSinatra < Sinatra::Base
  #configure :development do
    register Sinatra::Reloader
  #end

  helpers Sinatra::Spring

  set :environment, :development

  get "/customers" do
    repo = bean("customerRepository")

    cust1 = Java::JavasinatraCoreModel::Customer.new
    cust1.name = "Some Customer"
    cust1.email = "customer@domain.com"
    repo.save cust1

    bean("customerRepository").all
  end

end


