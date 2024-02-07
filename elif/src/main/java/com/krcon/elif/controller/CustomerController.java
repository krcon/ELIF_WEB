package com.krcon.elif.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.krcon.elif.common.service.CommonService;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.ExcelExportUtil;
import com.krcon.elif.common.util.MailHandler;
import com.krcon.elif.pagination.PaginationInfo;
import com.krcon.elif.service.CodeService;
import com.krcon.elif.service.ComplexService;
import com.krcon.elif.service.CustomerService;
import com.krcon.elif.service.LogService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.Code;
import com.krcon.elif.vo.Complex;
import com.krcon.elif.vo.Customer;
import com.krcon.elif.vo.Log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Configuration
@PropertySource("classpath:system.properties")

@RequestMapping(value = "mgmt")
@Controller
public class CustomerController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.domainName}")
	private String domainName;

	@Resource(name = "customerService")
	private CustomerService customerService;

	@Resource(name = "logService")
	private LogService logService;
	
	@Resource(name = "codeService")
	private CodeService codeService;
	
	@Resource(name = "commonService")
	private CommonService commonService;

	@Autowired
	ComplexService complexService;
	
	@Value("${sys.mail.address}")
	private String mailFrom;

	@Value("${sys.adminlink}")
    private String adminlink;
	
	@Autowired
    public JavaMailSender mailSender;

	/******************************************************************************************************************/
	/*************************************************   고객관리 제품문의    ***************************************************/
	/******************************************************************************************************************/
	@RequestMapping(value = {"/customer/qna" })
	public ModelAndView selectInquiryList(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/qna/list");
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(customerVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(customerVO.getRecordCountPerPage());
        paginationInfo.setPageSize(customerVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = customerService.selectInquiryCount(customerVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		customerVO.setStart(start);
		customerVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Customer> list = customerService.selectInquiryList(customerVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
		

        List<Customer> delist = customerService.selectInquiryDeleteList(customerVO);
        mv.addObject("delist", delist);

		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}



		if (customerVO.getLang() != null) {
			mv.addObject("lang", customerVO.getLang());
		}
		if (customerVO.getReply_status() != null) {
			mv.addObject("reply_status", customerVO.getReply_status());
		}
		if (customerVO.getSdate() != null) {
			mv.addObject("sdate", customerVO.getSdate());
		}
		if (customerVO.getEdate() != null) {
			mv.addObject("edate", customerVO.getEdate());
		}
		if (customerVO.getLang() != null) {
			mv.addObject("lang", customerVO.getLang());
		}

		return mv;
	}
	
	
	/** 
	 * @param customerVO
	 * @param reason
	 * @param request
	 * @return ResponseEntity<byte[]>
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/qna/exceldown" })
    public ResponseEntity<byte[]> exceldown(Customer customerVO,@RequestParam(name = "reason") String reason, HttpServletRequest request) throws Exception {
        /*** 1. 운영자로그 - 엑셀다운로그에 로그저장 ***/
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		Log logVO = new Log();
		logVO.setUsername(principal.getName());
		logVO.setUserid(principal.getUserid());
		logVO.setDepartment(principal.getDepartment());
		logVO.setAccess_menu("관심고객리스트");
		logVO.setReason(reason);
		logVO.setLogin_ip(principal.getLogin_ip());
    	logService.insertLogExcel(logVO);
        
        /*** 2. 엑셀파일 생성 ***/
    	Long startTime = System.currentTimeMillis();
        List<Customer> list = customerService.selectNewsletterList(customerVO);
        
        ExcelExportUtil excelUtil = new ExcelExportUtil();
        ResponseEntity<byte[]> result = excelUtil.makeNewsletter(list);

        Long endTime = System.currentTimeMillis();
        log.info("download excel request->" + (endTime - startTime) / 1000 + " seconds");

        return result;
    }
	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/qna/view" })
	public ModelAndView qnaView(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/qna/view");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		Customer customerAdminVO = new Customer();
		customerAdminVO.setTarget("userid");
		customerAdminVO.setKeyword(principal.getUserid());
		int countAdmin =customerService.selectAdminCount(customerAdminVO);
		if(countAdmin==0){
			mv.setViewName("redirect:/mgmt/customer/qna?error=noadmin");
			return mv;
		}
		
		// 1. IDX로 문의내용 조회
		Customer detail = customerService.selectInquiry(customerVO);
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd");
		// customerVO.setMerge_dtm(format.format(detail.getCrea_dtm()));
		log.info("::::::::::::::::::{}",detail.getMerge_dtm());

		if(!CommonUtils.isEmpty(detail.getLang())){
			String[] values = detail.getLang().split(",");
			if(values != null){
				customerVO.setLangs(values);
			}
		}
		List<Customer> list = customerService.selectAdminInCharge(customerVO);
		
		mv.addObject("map", detail);
		mv.addObject("list", list);
		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/qna/status")
	public ModelAndView updateInquiry(Customer customerVO,HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy. MM. dd HH:mm"));
		String nowDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일"));
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		Account principal = (Account) auth.getPrincipal();
		customerVO.setReply_id(principal.getUserid());
		customerVO.setReply_name(principal.getName());
		customerService.updateInquiryStatus(customerVO);
		if(customerVO.getReply_status().equals("RV02303")){
			Customer customerMailVO = customerService.selectInquiry(customerVO);
	
			// 메일 보내기
			HashMap<String,Object> mapMail = new HashMap<String,Object>();
			
			mapMail.put("inquiry_content", customerMailVO.getInquiry_content());
			mapMail.put("crea_dtm", format.format(customerMailVO.getCrea_dtm()));
			mapMail.put("reply_content", customerMailVO.getReply_content());

			
			mapMail.put("date", nowDate);
			mapMail.put("time", nowTime);
			mapMail.put("domain", domain);
			mapMail.put("department", customerMailVO.getDepartment());
			mapMail.put("name", customerMailVO.getName());
			mapMail.put("email", customerMailVO.getEmail());
			mapMail.put("tel", customerMailVO.getTel());
			mapMail.put("title", customerMailVO.getTitle());

			mapMail.put("complex_name", customerMailVO.getComplex_name());
			
			String mailFile = "customer_answer";
			MailHandler.getMailSend(mailSender,mailFrom,customerMailVO.getEmail(),"[계룡 엘리프] 고객 문의 답변 알림 메일",mailFile,mapMail);
			

		}
		mv.addObject("result", "ok");
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/qna/delete")
	public ModelAndView deleteInquiry(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/qna");
		
		
		customerVO.setParamIdx(customerVO.getArrIdx().split(","));
		customerService.deleteInquiry(customerVO);
		
		return mv;
	}
	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/qna/deleteAll")
	public ModelAndView deleteInquiryAll(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/qna");
		customerService.deleteInquiryAll(customerVO);
		
		return mv;
	}
	
	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/qna/deleteAllProc")
	public ModelAndView deleteInquiryAllProc(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/qna");
		customerService.deleteInquiryAll(customerVO);
		
		return mv;
	}
	
	
	/******************************************************************************************************************/
	/*************************************************  고객문의 담당자    ***************************************************/
	/******************************************************************************************************************/
	@RequestMapping(value = {"/customer/manager" })
	public ModelAndView selectAdminList(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/manager/list");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		if(customerVO.getLang()!=null) {
			String[] values = customerVO.getLang().split(",");
			if(values != null){
				customerVO.setLangs(values);
			}
		}
    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(customerVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(customerVO.getRecordCountPerPage());
        paginationInfo.setPageSize(customerVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = customerService.selectAdminCount(customerVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		customerVO.setStart(start);
		customerVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Customer> list = customerService.selectAdminList(customerVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);
        mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		
		return mv;
	}
		
	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/manager/write" })
	public ModelAndView adminWrite(Customer customerVO, HttpServletRequest request) throws Exception {
		
		ModelAndView mv = new ModelAndView("/mgmt/customer/manager/write");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());

		return mv;
	}
	
	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/manager/writeProc")
	public ModelAndView insertAdmin(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/manager");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		customerVO.setCrea_id(principal.getUsername());
		customerVO.setCrea_name(principal.getName());
		
		customerService.insertAdmin(customerVO);
		
		return mv;
	}

	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/manager/modify" })
	public ModelAndView adminUpdate(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/manager/modify");
		
		Customer resultMap =customerService.selectAdmin(customerVO);
		
		mv.addObject("map", resultMap);

		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		return mv;
	}	
	
	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/manager/modifyProc")
	public ModelAndView updateAdmin(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/manager");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		customerVO.setUpda_id(principal.getUsername());
		customerVO.setUpda_name(principal.getName());
		customerService.updateAdmin(customerVO);
		
		return mv;
	}
	
	
	/** 
	 * @param customerVO
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value ="/customer/manager/delete")
	public ModelAndView deleteAdmin(Customer customerVO) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/customer/manager");
		customerService.deleteAdmin(customerVO);
		
		return mv;
	}
	
	/******************************************************************************************************************/
	/*************************************************  뉴스레터 구독자    ***************************************************/
	/******************************************************************************************************************/
	@RequestMapping(value = {"/customer/newsletter" })
	public ModelAndView selectNewlsetterList(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/newsletter/list");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
    	PaginationInfo paginationInfo = null;
         
        paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(customerVO.getCurrentPageNo());
        paginationInfo.setRecordCountPerPage(customerVO.getRecordCountPerPage());
        paginationInfo.setPageSize(customerVO.getPageSize());
        int start = paginationInfo.getFirstRecordIndex();
        int end = paginationInfo.getRecordCountPerPage();
        
        int total = customerService.selectNewsletterCount(customerVO);
		if(paginationInfo != null){
			paginationInfo.setTotalRecordCount(total);
		}
		customerVO.setStart(start);
		customerVO.setEnd(paginationInfo.getLastRecordIndex());

        List<Customer> list = customerService.selectNewsletterList(customerVO);
         
        mv.addObject("paginationInfo", paginationInfo);
        mv.addObject("list", list);

		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		
		return mv;
	}
	
	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/newsletter/view" })
	public ModelAndView selectNewsletter(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/customer/newsletter/view");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		Customer resultMap =customerService.selectNewsletter(customerVO);
		
		mv.addObject("map", resultMap);
		mv.addObject("currentPageNo", customerVO.getCurrentPageNo());
		if (customerVO.getTarget() != null) {
			mv.addObject("target", customerVO.getTarget());
		}
		if (customerVO.getKeyword() != null) {
			mv.addObject("keyword", customerVO.getKeyword());
		}
		return mv;
	}
	
	/** 
	 * @param customerVO
	 * @param reason
	 * @param request
	 * @return ResponseEntity<byte[]>
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/newsletter/exceldown" })
    public ResponseEntity<byte[]> newsletter_exceldown(Customer customerVO,@RequestParam(name = "reason") String reason, HttpServletRequest request) throws Exception {
        /*** 1. 운영자로그 - 엑셀다운로그에 로그저장 ***/
    	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		Log logVO = new Log();
		logVO.setUsername(principal.getName());
		logVO.setUserid(principal.getUserid());
		logVO.setDepartment(principal.getDepartment());
		logVO.setAccess_menu("관심고객리스트");
		logVO.setReason(reason);
		logVO.setLogin_ip(principal.getLogin_ip());
    	logService.insertLogExcel(logVO);
        
        /*** 2. 엑셀파일 생성 ***/
    	Long startTime = System.currentTimeMillis();
        List<Customer> list = customerService.selectNewsletterList(customerVO);
        
        ExcelExportUtil excelUtil = new ExcelExportUtil();
        ResponseEntity<byte[]> result = excelUtil.makeNewsletter(list);

        Long endTime = System.currentTimeMillis();
        log.info("download excel request->" + (endTime - startTime) / 1000 + " seconds");


        return result;
    }
	
	/** 
	 * @param customerVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = {"/customer/newsletter/delete" })
	public ModelAndView deleteNewsletter(Customer customerVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/mgmt/customer/newsletter");
		customerService.deleteNewsletter(customerVO);
		return mv;
	}
	

}