package javasinatra.repository;

import javasinatra.core.model.Customer;

public interface CustomerRepository {

    Customer find(Long id);
    
    void save(Customer c);
    
}
