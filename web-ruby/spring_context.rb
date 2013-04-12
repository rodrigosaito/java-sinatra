java_import org.springframework.context.annotation.AnnotationConfigApplicationContext

module Spring

  class Context

    def self.bean_factory
      @bean_factory ||= create_bean_factory
    end

    def self.create_bean_factory
      #Java::OrgSpringframeworkContextAnnotation::AnnotationConfigApplicationContext.new Java::JavasinatraCore::AppConfig.java_class
      AnnotationConfigApplicationContext.new Java::JavasinatraCore::AppConfig.java_class
    end

  end

end
