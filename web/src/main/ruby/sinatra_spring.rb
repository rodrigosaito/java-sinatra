require "java"

java_import org.springframework.context.annotation.AnnotationConfigApplicationContext

module Sinatra

  module Spring

    def bean(name)
      SpringContext.instance.getBean(name)
    end

    class SpringContext

      def self.instance
        @spring_context ||= create_spring_context
      end

      def self.create_spring_context
        AnnotationConfigApplicationContext.new Java::JavasinatraCore::AppConfig.java_class
      end

    end

  end

  helpers Spring

end