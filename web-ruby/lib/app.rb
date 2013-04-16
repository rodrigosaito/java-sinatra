require "java"

require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"
require "poncho"

require_relative "spring/context"
require_relative "sinatra/spring"

# Populating database
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

class CustomerResource < Poncho::Resource

  param :id
  param :name
  param :email

end

class RetrieveCustomerListMethod < Poncho::JSONMethod
  include Sinatra::Spring

  param :id

  def invoke
    [].tap do |list|
      spring_bean("customerRepository").all.each do |cust|
        list << CustomerResource.new(cust)
      end
    end
  end
end

class RetrieveCustomerMethod < Poncho::JSONMethod
  include Sinatra::Spring

  param :id, type: :integer, required: true

  def invoke
    CustomerResource.new(spring_bean("customerRepository").find(param(:id)))
  end

end

class CreateCustomerMethod < Poncho::JSONMethod
  include Sinatra::Spring

  param :name
  param :email

  def invoke
    puts "name = #{param(:name)}"
    puts "email = #{param(:email)}"

=begin
    transactionTemplate.execute Class.new(Java::OrgSpringframeworkTransactionSupport::TransactionCallbackWithoutResult) do
      def doInTransactionWithoutResult(status)
        customer = Java::JavasinatraCoreModel::Customer.new
        customer.name = param(:name)
        customer.email = param(:email)

        spring_bean("customerRepository").save(customer)
      end
    end.new
=end
  end

end

class JavaSinatra < Sinatra::Base

  configure :development do
    register Sinatra::Reloader

    Dir[File.expand_path(File.dirname(__FILE__))+ "/**/*.rb"].each { |file| also_reload file }
  end

  helpers Sinatra::Spring

  post "/customers", &CreateCustomerMethod

  get "/customers", &RetrieveCustomerListMethod

  get "/customers/:id", &RetrieveCustomerMethod

end

