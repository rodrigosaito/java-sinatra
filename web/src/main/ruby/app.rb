APP_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(APP_ENV)

require 'sinatra/base'
require 'sinatra/reloader'

require 'spring'

java_import 'javasinatra.core.model.Customer'

class JavaSinatra < Sinatra::Base
  helpers Spring::Base

  use Spring::TransactionMiddleware

  set :environment, :development

  def customerRepository
    bean("customerRepository")
  end

  get "/customers" do
    customerRepository.all.to_s
  end

  post "/customers" do
    c = Customer.new

    c.name = "Another Customer"
    c.email = "another@domain.com"

    customerRepository.save c
  end

end


