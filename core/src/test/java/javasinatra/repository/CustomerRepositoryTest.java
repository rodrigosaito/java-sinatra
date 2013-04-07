package javasinatra.repository;

import static org.junit.Assert.assertNotNull;
import javasinatra.core.AppConfig;
import javasinatra.core.model.Customer;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.AnnotationConfigContextLoader;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

@ContextConfiguration(loader = AnnotationConfigContextLoader.class, classes = AppConfig.class)
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional
@TransactionConfiguration(defaultRollback = true)
public class CustomerRepositoryTest {

    @Autowired
    private CustomerRepositoryImpl repo;
    
    @Test
    public void testFind() {
        Customer c = new Customer();
        c.setName( "Some Customer");
        c.setEmail("some_customer@domain.com");
        repo.save(c);
        
        assertNotNull(repo.find(c.getId()));
    }
    
}
