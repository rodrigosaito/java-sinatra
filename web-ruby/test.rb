require "java"

Dir[File.expand_path(File.dirname(__FILE__) + "/jars/*.jar")].each { |file| puts "Requiring jar: #{file}"; require file }

java_import org.springframework.context.annotation.AnnotationConfigApplicationContext

context = AnnotationConfigApplicationContext.new Java::JavasinatraCore::AppConfig.java_class