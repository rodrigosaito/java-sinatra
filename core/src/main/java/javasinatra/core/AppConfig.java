package javasinatra.core;

import javasinatra.repository.CustomerRepositoryImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.instrument.classloading.InstrumentationLoadTimeWeaver;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;

import javax.sql.DataSource;

@Configuration
@ImportResource("classpath:spring-orm.xml")
public class AppConfig {

	public static final String DATABASE_DIALECT = "DATABASE_DIALECT";
	public static final String DATABASE_URL = "DATABASE_URL";
	public static final String DATABASE_DRIVER = "DATABASE_DRIVER";
	public static final String DATABASE_HBM2DDL = "DATABASE_HBM2DDL";

	@Bean
	public DataSource dataSource() {
		String url = System.getProperty(DATABASE_URL);
		String username = System.getProperty("DATABASE_USERNAME");
		String password = System.getProperty("DATABASE_PASSWORD");

		return new DriverManagerDataSource(url, username, password);
	}

	@Bean
	public LocalContainerEntityManagerFactoryBean emf() {
		LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();

		emf.setDataSource(dataSource());
		emf.setLoadTimeWeaver(new InstrumentationLoadTimeWeaver());
		emf.getJpaPropertyMap().put("hibernate.dialect", System.getProperty(DATABASE_DIALECT));
		emf.getJpaPropertyMap().put("hibernate.hbm2ddl.auto", "update");

		return emf;
	}

    @Bean
    public CustomerRepositoryImpl customerRepository() {
        return new CustomerRepositoryImpl();
    }

}
