package com.krcon.elif.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krcon.elif.dao.CustomerDAO;

import com.krcon.elif.vo.Customer;

@Configuration
@PropertySource("classpath:system.properties")

@Service("customerService")
public class CustomerServiceImpl implements CustomerService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("${sys.inquiry.delete}")
    private String delPiriod;
	
    @Resource(name="customerDAO")
    private CustomerDAO customerDAO;
    
	
	public Customer selectInquiry(Customer customerVO) throws Exception {
		return customerDAO.selectInquiry(customerVO);
	}

	public List<Customer> selectInquiryList(Customer customerVO) throws Exception {
		return customerDAO.selectInquiryList(customerVO);
	}

	public int selectInquiryCount(Customer customerVO) throws Exception {
		return customerDAO.selectInquiryCount(customerVO);
	}
	
	public void updateInquiryStatus(Customer customerVO) throws Exception {
		customerDAO.updateInquiryStatus(customerVO);
	}
	public void deleteInquiry(Customer customerVO) throws Exception {
		customerDAO.deleteInquiry(customerVO);
	}
	
	public List<Customer> selectInquiryDeleteList(Customer customerVO) throws Exception {
		customerVO.setDel_piriod(delPiriod);
		return customerDAO.selectInquiryDeleteList(customerVO);
	}
	
	public void deleteInquiryAll(Customer customerVO) throws Exception {
		customerVO.setDel_piriod(delPiriod);
		customerDAO.deleteInquiryAll(customerVO);
	}
	
	public Customer selectAdmin(Customer customerVO) throws Exception {
		return customerDAO.selectAdmin(customerVO);
	}
	
	public List<Customer> selectAdminList(Customer customerVO) throws Exception {
		return customerDAO.selectAdminList(customerVO);
	}
	public int selectAdminCount(Customer customerVO) throws Exception {
		return customerDAO.selectAdminCount(customerVO);
	}
	
	
	public List<Customer> selectAdminInCharge(Customer customerVO) throws Exception {
		return customerDAO.selectAdminInCharge(customerVO);
	}
	
	
	/** 
	 * @param customerVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertCustomer(Customer customerVO) throws Exception {
		return customerDAO.insertCustomer(customerVO);
	}
	
	@Transactional(rollbackFor = Exception.class)
	public void insertAdmin(Customer customerVO) throws Exception {
		customerDAO.insertAdmin(customerVO);
	}
	
	public void updateAdmin(Customer customerVO) throws Exception {
		customerDAO.updateAdmin(customerVO);
	}
	
	public void deleteAdmin(Customer customerVO) throws Exception {
		customerDAO.deleteAdmin(customerVO);
	}

	
	public Customer selectNewsletter(Customer customerVO) throws Exception {
		return customerDAO.selectNewsletter(customerVO);
	}
	
	public List<Customer> selectNewsletterList(Customer customerVO) throws Exception {
		return customerDAO.selectNewsletterList(customerVO);
	}
	public int selectNewsletterCount(Customer customerVO) throws Exception {
		return customerDAO.selectNewsletterCount(customerVO);
	}
	public void deleteNewsletter(Customer customerVO) throws Exception {
		customerDAO.deleteNewsletter(customerVO);
	}
	
	public List<Customer> selectNewsletterExcel(Customer customerVO) throws Exception {
		return customerDAO.selectNewsletterExcel(customerVO);
	}
}	
