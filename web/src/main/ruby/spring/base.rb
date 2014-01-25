module Spring

  module Base

    def bean(name)
      Context.instance.getBean(name)
    end

  end

end
