require "java"

require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"

require_relative "spring/context"
require_relative "sinatra/spring"


txManager = ::Spring::Context.bean_factory.get_bean("transactionManager")

transactionTemplate = Java::OrgSpringframeworkTransactionSupport::TransactionTemplate.new txManager

class AddCustomer < Java::OrgSpringframeworkTransactionSupport::TransactionCallbackWithoutResult

  def doInTransactionWithoutResult(status)
    custRepo = ::Spring::Context.bean_factory.get_bean("customerRepository")

    customer = Java::JavasinatraCoreModel::Customer.new
    customer.name = "Some Customer"
    customer.email = "customer@domain.org"

    custRepo.save customer
  end

end

transactionTemplate.execute(AddCustomer.new)

class JavaSinatra < Sinatra::Base

  configure :development do
    register Sinatra::Reloader

    Dir[File.expand_path(File.dirname(__FILE__))+ "/**/*.rb"].each { |file| also_reload file }
  end

  helpers Sinatra::Spring
  helpers Sinatra::JSON

  get "/customers" do
    spring_bean("customerRepository").all.to_s
  end

end

