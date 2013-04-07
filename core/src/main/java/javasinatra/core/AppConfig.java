package javasinatra.core;

import javasinatra.repository.CustomerRepositoryImpl;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;

@Configuration
@ImportResource("classpath:spring-orm.xml")
public class AppConfig {

    @Bean
    public CustomerRepositoryImpl customerRepository() {
        return new CustomerRepositoryImpl(); 
    }
    
}
