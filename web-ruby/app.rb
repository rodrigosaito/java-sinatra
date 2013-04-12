require "java"

require "sinatra/base"
require "sinatra/reloader"

require "spring_context"
require_relative "sinatra_spring"

class JavaSinatra < Sinatra::Base

  configure :development do
    register Sinatra::Reloader

    Dir[File.expand_path(File.dirname(__FILE__))+ "/**/*.rb"].each { |file| also_reload file }
  end

  helpers Sinatra::Spring

  get "/customers" do
    spring_bean("customerRepository")

  end

end

