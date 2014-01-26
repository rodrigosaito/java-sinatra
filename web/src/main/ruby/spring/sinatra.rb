java_import 'org.springframework.context.annotation.AnnotationConfigApplicationContext'

require 'sinatra/base'

module Spring

  module Sinatra

    include Base

  end

  ::Sinatra.helpers Sinatra

end
