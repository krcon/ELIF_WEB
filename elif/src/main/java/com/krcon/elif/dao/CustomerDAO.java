package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDAO;

import com.krcon.elif.vo.Customer;

@Repository("customerDAO")
public class CustomerDAO extends AbstractDAO{
	/** 고객관리 제품문의 **/
	public Customer selectInquiry(Customer customerVO) throws Exception{
	    return (Customer) selectOne("customer.selectInquiry", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectInquiryList(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectInquiryList", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return int
	 * @throws Exception
	 */
	public int selectInquiryCount(Customer customerVO) throws Exception{
	    return (Integer) selectOne("customer.selectInquiryCount", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void updateInquiryStatus(Customer customerVO) throws Exception{
	    update("customer.updateInquiryStatus", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void deleteInquiry(Customer customerVO) throws Exception{
	    update("customer.deleteInquiry", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectInquiryDeleteList(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectInquiryDeleteList", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void deleteInquiryAll(Customer customerVO) throws Exception{
	    update("customer.deleteInquiryAll", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return int
	 * @throws Exception
	 */
	public int insertCustomer(Customer customerVO) throws Exception {
		return (int) insert("customer.insertCustomer", customerVO);
	}



	/** 고객관리 고객문의 담당자 **/
	public Customer selectAdmin(Customer customerVO) throws Exception{
	    return (Customer) selectOne("customer.selectAdmin", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectAdminList(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectAdminList", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return int
	 * @throws Exception
	 */
	public int selectAdminCount(Customer customerVO) throws Exception{
	    return (Integer) selectOne("customer.selectAdminCount", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectAdminInCharge(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectAdminInCharge", customerVO);
	}
	
	
//	public int insertAdmin(Customer customerVO) throws Exception{
//	    insert("customer.insertAdmin", customerVO);
//	    return Integer.parseInt(String.valueOf(map.get("IDX")));
//	}
	
	public void insertAdmin(Customer customerVO) throws Exception{
	    insert("customer.insertAdmin", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void updateAdmin(Customer customerVO) throws Exception{
	    update("customer.updateAdmin", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void deleteAdmin(Customer customerVO) throws Exception{
	    update("customer.deleteAdmin", customerVO);
	}
	
	/** 고객관리 뉴스레터 구독자 **/
	public Customer selectNewsletter(Customer customerVO) throws Exception{
	    return (Customer) selectOne("customer.selectNewsletter", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectNewsletterList(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectNewsletterList", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return int
	 * @throws Exception
	 */
	public int selectNewsletterCount(Customer customerVO) throws Exception{
	    return (Integer) selectOne("customer.selectNewsletterCount", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @throws Exception
	 */
	public void deleteNewsletter(Customer customerVO) throws Exception{
		 selectOne("customer.deleteNewsletter", customerVO);
	}
	
	/** 
	 * @param customerVO
	 * @return List<Customer>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> selectNewsletterExcel(Customer customerVO) throws Exception{
	    return (List<Customer>)selectList("customer.selectNewsletterExcel", customerVO);
	}
	
	
}