package javasinatra.repository;

import javasinatra.core.AppConfig;
import javasinatra.core.model.Customer;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.AnnotationConfigContextLoader;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.Assert.assertNotNull;

@ContextConfiguration(loader = AnnotationConfigContextLoader.class, classes = AppConfig.class)
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
@TransactionConfiguration(defaultRollback = true)
public class CustomerRepositoryTest {

    @Autowired
    private CustomerRepositoryImpl repo;

    @BeforeClass
    public static void configureDS() {
    	System.setProperty(AppConfig.DATABASE_URL, "jdbc:hsqldb:mem:javasinatra");
    	System.setProperty(AppConfig.DATABASE_DIALECT, "org.hibernate.dialect.HSQLDialect");
    	System.setProperty(AppConfig.DATABASE_DRIVER, "org.hsqldb.jdbcDriver");
    	System.setProperty(AppConfig.DATABASE_HBM2DDL, "update");
    }

    @Test
    public void testFind() {
        Customer c = new Customer();
        c.setName( "Some Customer");
        c.setEmail("some_customer@domain.com");
        repo.save(c);

        assertNotNull(repo.find(c.getId()));
    }

}
