APP_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(APP_ENV)

require 'sinatra/base'
require 'sinatra/reloader'

require 'sinatra_spring'


class JavaSinatra < Sinatra::Base
  #configure :development do
    register Sinatra::Reloader
  #end

  helpers Sinatra::Spring

  set :environment, :development

  get "/customers" do
    puts "funciona? nao"
    repo = bean("customerRepository")

    cust1 = Java::JavasinatraCoreModel::Customer.new
    cust1.name = "Some Customer"
    cust1.email = "customer@domain.com"
    repo.save cust1

    bean("customerRepository").all
  end

end


