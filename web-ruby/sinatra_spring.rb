# TODO fix this


module Sinatra

  module Spring

    def spring_bean(name)
      ::Spring::Context.bean_factory.bean(name)
    end

  end

  helpers Spring

end
