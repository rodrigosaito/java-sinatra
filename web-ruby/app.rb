require "sinatra/base"
require "sinatra/reloader"

class JavaSinatra < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get "/customers" do
    "Funciona!"
  end

end

