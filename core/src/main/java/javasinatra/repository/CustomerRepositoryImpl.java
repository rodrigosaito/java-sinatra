package javasinatra.repository;

import java.util.List;

import javasinatra.core.model.Customer;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

public class CustomerRepositoryImpl implements CustomerRepository {

    @PersistenceContext
    private EntityManager em;
    
    @Override
    public Customer find(Long id) {
        return em.find(Customer.class, id);
    }
    
    public void save(Customer c) {
        em.persist(c);
    }

    @Override
    public List<Customer> all() {
        return em.createQuery("from Customer", Customer.class).getResultList();
    }
    
    @Override
    public void deleteAll() {
    	em.createQuery("delete from Customer").executeUpdate();
    }
    
}
