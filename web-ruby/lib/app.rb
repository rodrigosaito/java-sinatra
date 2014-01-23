require "java"

require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"
require "poncho"

#require "grape"
#require "grape-entity"

require_relative "spring/context"
require_relative "spring/transaction"
require_relative "sinatra/spring"

# Populating database
# txManager = ::Spring::Context.bean_factory.get_bean("transactionManager")

# transactionTemplate = Java::OrgSpringframeworkTransactionSupport::TransactionTemplate.new txManager

# class AddCustomer < Java::OrgSpringframeworkTransactionSupport::TransactionCallbackWithoutResult

#   def doInTransactionWithoutResult(status)
#     custRepo = ::Spring::Context.bean_factory.get_bean("customerRepository")

#     customer = Java::JavasinatraCoreModel::Customer.new
#     customer.name = "Some Customer"
#     customer.email = "customer@domain.org"

#     custRepo.save customer
#   end

# end

# transactionTemplate.execute(AddCustomer.new)

module Spring

  def spring_bean(name)
    ::Spring::Context.bean(name)
  end

end

=begin
class CustomerResource < Grape::Entity

  expose :name
  expose :email

end


class API < Grape::API

  format :json

  helpers do
    def spring_bean(name)
      ::Spring::Context.bean(name)
    end
  end

  resource :customers do

    get do
      spring_bean("customerRepository").all
    end

    get ":id" do
      customer = spring_bean("customerRepository").find params[:id]
      present customer, with: CustomerResource
    end

  end

end
=end


class CustomerResource < Poncho::Resource

  param :id
  param :name
  param :email

end

class TransactionalJSONMethod < Poncho::JSONMethod

  def invoke
    do_invoke
  end

end


class RetrieveCustomerListMethod < TransactionalJSONMethod
  include Sinatra::Spring

  param :id

  def do_invoke
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
    puts "id = #{param(:id).methods.grep /to_/}"

    customer = spring_bean("customerRepository").find(param(:id))

    puts "customer = #{customer.class}"

    halt 404 unless customer

    CustomerResource.new(customer)
  end

end

class CreateCustomerMethod < Poncho::JSONMethod
  include Sinatra::Spring

  param :customer, resource: CustomerResource

  def invoke
    puts "customer = #{param(:customer)}"
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
