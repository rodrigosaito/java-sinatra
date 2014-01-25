module Spring
  class Context

    def self.instance
      @context ||= create_spring_context
    end

    def self.create_spring_context
      AnnotationConfigApplicationContext.new Java::JavasinatraCore::AppConfig.java_class
    end

  end
end
