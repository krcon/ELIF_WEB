package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.Customer;

public interface CustomerService {
	Customer selectInquiry(Customer customerVO) throws Exception;
	List<Customer> selectInquiryList(Customer customerVO) throws Exception;
	int selectInquiryCount(Customer customerVO) throws Exception;
    void updateInquiryStatus(Customer customerVO) throws Exception;
    void deleteInquiry(Customer customerVO) throws Exception;
    List<Customer> selectInquiryDeleteList(Customer customerVO) throws Exception;
    void deleteInquiryAll(Customer customerVO) throws Exception;

	int insertCustomer(Customer customerVO) throws Exception;

    
	Customer selectAdmin(Customer customerVO) throws Exception;
	List<Customer> selectAdminList(Customer customerVO) throws Exception;
	int selectAdminCount(Customer customerVO) throws Exception;
	List<Customer> selectAdminInCharge(Customer customerVO) throws Exception;
	
	
	void insertAdmin(Customer customerVO) throws Exception;
	void updateAdmin(Customer customerVO) throws Exception;
	void deleteAdmin(Customer customerVO) throws Exception;
    
	Customer selectNewsletter(Customer customerVO) throws Exception;
	List<Customer> selectNewsletterList(Customer customerVO) throws Exception;
	int selectNewsletterCount(Customer customerVO) throws Exception;
	void deleteNewsletter(Customer customerVO) throws Exception;
	List<Customer> selectNewsletterExcel(Customer customerVO) throws Exception;
	

}