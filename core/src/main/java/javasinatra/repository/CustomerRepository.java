package javasinatra.repository;

import java.util.List;

import javasinatra.core.model.Customer;

public interface CustomerRepository {

    Customer find(Long id);
    
    void save(Customer c);
    
    List<Customer> all();
    
}
