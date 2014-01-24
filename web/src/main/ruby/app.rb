APP_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(APP_ENV)

require 'sinatra/base'
require 'sinatra/reloader'

require 'sinatra_spring'
require "transaction"

java_import 'javasinatra.core.model.Customer'

class TransactionMiddleware

  def initialize(app)
    @app = app
  end

  def call(env)
    Spring::Transaction.execute do
      @app.call(env)
    end
  end

end

class JavaSinatra < Sinatra::Base
  helpers Sinatra::Spring

  use TransactionMiddleware

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


