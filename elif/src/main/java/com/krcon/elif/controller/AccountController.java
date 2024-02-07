package com.krcon.elif.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.text.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.JsonUtil;
import com.krcon.elif.common.util.MailHandler;
import com.krcon.elif.common.util.TempKey;
import com.krcon.elif.service.AccountService;
import com.krcon.elif.service.AdminMenuService;
import com.krcon.elif.service.LogService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AccountIp;
import com.krcon.elif.vo.AdminMenu;
import com.krcon.elif.vo.Log;
import com.krcon.elif.pagination.PaginationInfo;

@Controller
public class AccountController {
	@Autowired
    public JavaMailSender mailSender;
	
	@Autowired
	AccountService accountService;

	@Autowired
	AdminMenuService adminMenuService;
	
	@Autowired
	LogService logService;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Value("${sys.adminlink}")
    private String adminlink;
	
	@Value("${sys.mail.address}")
    private String mailFrom;
	
	private final Logger log = LoggerFactory.getLogger(this.getClass());
	private final String adminUrl = "mgmt";


	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (request.getSession().getAttribute("admin") != null) {
			mv.setViewName("redirect:/" + adminUrl + "/logout");
		} else {
			if (request.getParameter("redirect") == null) {
				mv.addObject("redirectUrl", "/" + adminUrl + "/user/home");
			} else {
				mv.addObject("redirectUrl", request.getParameter("redirect"));
			}
			mv.setViewName("/mgmt/user/login");
		}
		
		
		return mv;
	}

	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/loginip", method = RequestMethod.GET)
	public ModelAndView loginIp(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();

		String ip = CommonUtils.getClientIp(request);
		AccountIp accountIp = new AccountIp();
		accountIp.setIp(CommonUtils.getClientIp(request));
		List<AccountIp> ipdetail = accountService.selectIP(accountIp);
		boolean ipbool = false;
		if (ipdetail.size() > 0) {
			for (AccountIp entry : ipdetail) {
				if (entry.getIp().equals("0.0.0.0")) {
					ipbool = true;
					break;
				} else if (entry.getIp().equals(ip)) {
					ipbool = true;
					break;
				}
			}
		} else {
			ipbool = true;
		}
		if (ipbool == true) {

			if (request.getSession().getAttribute("admin") != null) {
				mv.setViewName("redirect:/" + adminUrl + "/logout");
			} else {
				if (request.getParameter("redirect") == null) {
					mv.addObject("redirectUrl", "/" + adminUrl + "/user/home");
				} else {
					mv.addObject("redirectUrl", request.getParameter("redirect"));
				}
				mv.setViewName("/mgmt/user/login");
			}
		} else {
			mv.setViewName("/error");
		}
		return mv;
	}
	
	/** 
	 * @param account
	 * @param request
	 * @param type
	 * @param token
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/reset/{type}/{token}", method = RequestMethod.GET)
	public ModelAndView changepwd(Account account, HttpServletRequest request, @PathVariable("type") String type,@PathVariable("token") String token) throws Exception {
		ModelAndView mv = new ModelAndView();

		account.setToken(token);
		Account detail = accountService.selectMemberTokenDetail(account);
		if(detail==null) {
			mv.setViewName("redirect:/" + adminUrl + "/login");
		}else {
			mv.setViewName("/" + adminUrl + "/user/changepwd");

			mv.addObject("type", type);
			mv.addObject("token", token);
		}
		return mv;
	}
	
	
	/** 
	 * @param account
	 * @param request
	 * @param type
	 * @param token
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/reset/{type}/{token}", method = RequestMethod.POST)
	public ModelAndView changepwdProc(Account account, HttpServletRequest request, @PathVariable("type") String type,@PathVariable("token") String token) throws Exception {
		ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();

		account.setToken(token);
		Account detail = accountService.selectMemberTokenDetail(account);
		
		String nowPassword = detail.getPassword();
		mv.setViewName("redirect:/reset/"+type+"/"+token);

		if ( !passwordEncoder.matches(account.getOld_password(),nowPassword)) {
			session.setAttribute("SITE_ERROR", "입력하신 기존 비밀번호와 현재 비밀번호가 일치하지 않습니다.");
		}else {
			if (!account.getPassword().equals(account.getPassword_comfirm())) {
				session.setAttribute("SITE_ERROR", "입력하신 신규 비밀번호와 신규 비밀번호 확인이 일치하지 않습니다.");
			}else {
				detail.setPassword(passwordEncoder.encode(account.getPassword()));
				detail.setAccountNonLocked(true);
				accountService.updateMemberPwd(detail);
				mv.setViewName("redirect:/" + adminUrl + "/login");
			}
		}
		
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/mgmt/anon/authsec", method = RequestMethod.GET)
	public ModelAndView authsec(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/" + adminUrl + "/user/authsec");
		return mv;
	}

	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/mgmt/anon/authemail", method = RequestMethod.POST)
	public ModelAndView authemail(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/" + adminUrl + "/user/authsec");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
		String url = domain+"/mgmt/login?gubun=init";
		HashMap<String,Object> mapMail = new HashMap<String,Object>();
		String mailNumber = new TempKey().generateRandomNumber(6);
		log.info("mailNumber:::::{}",mailNumber);
		mapMail.put("TITLE", "인증번호 안내");
		mapMail.put("PASSWORD", mailNumber );
		mapMail.put("TIME", nowTime);
		mapMail.put("ADMINURL", url);
		mapMail.put("domain", domain);
		mapMail.put("adminlink", adminlink);
		boolean mailbool = MailHandler.getMailSend(mailSender,mailFrom,principal.getEmail().toString(),"[계룡 엘리프 관리자] 인증번호 안내","loginemail",mapMail);
		principal.setMailNumber(mailNumber);
		mv.addObject("result", mailbool);
		mv.setViewName("jsonView");
		
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/mgmt/anon/authemailProc", method = RequestMethod.POST)
	public ModelAndView authemailProc(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/" + adminUrl + "/user/authsec");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		log.info("getMailNumber::::"+principal.getMailNumber().toString());
		if(principal.getMailNumber().toString().equals(account.getAuthnum())) {

			principal.setAuthsec_dtm(new Date());
			log.info(principal.getAuthsec_dtm().toString());
			accountService.updateLoginAuth(principal);
			mv.addObject("result", "Y");	
		}else {
			mv.addObject("result", "N");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	/** 
	 * @param account
	 * @param request
	 * @param response
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user")
	public ModelAndView openBoardList(Account account, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/user/list");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			response.setStatus(403);
		}
    	if("json".equals(account.getPage())){
	        List<Account> list = accountService.selectMemberList(account);
	        mv.addObject("list", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(account.getCurrentPageNo());
	        paginationInfo.setRecordCountPerPage(account.getRecordCountPerPage());
	        paginationInfo.setPageSize(account.getPageSize());
	        int start = paginationInfo.getFirstRecordIndex();
	        int end = paginationInfo.getRecordCountPerPage();
	        
	        int total = accountService.selectMemberCount(account);
			if(paginationInfo != null){
				paginationInfo.setTotalRecordCount(total);
			}
			account.setStart(start);
			account.setEnd(paginationInfo.getLastRecordIndex());

	        List<Account> list = accountService.selectMemberList(account);
	         
	        mv.addObject("paginationInfo", paginationInfo);
	        mv.addObject("list", list);
        }
		
		mv.addObject("currentPageNo", account.getCurrentPageNo());
		if (account.getTarget() != null) {
			mv.addObject("target", account.getTarget());
		}
		if (account.getKeyword() != null) {
			mv.addObject("keyword", account.getKeyword());
		}
		if (account.getSdate() != null) {
			mv.addObject("sdate", account.getSdate());
		}

		if (account.getEdate() != null) {
			mv.addObject("edate", account.getEdate());
		}

		return mv;
	}


	
	/** 
	 * @param account
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/emailSearch", method = RequestMethod.POST)
	public ModelAndView emailSearch(Account account) throws Exception {
		ModelAndView mv = new ModelAndView();
		int detail = accountService.emailSearch(account);
		mv.addObject("result", detail);
		mv.setViewName("jsonView");
		mv.addObject("account",null);
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/profile", method = RequestMethod.GET)
	public ModelAndView openProfile(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/user/profile");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		account.setUserid(principal.getUsername());
		Account detail = accountService.selectMemberDetail(account);
		mv.addObject("map", detail);
		log.info(detail.getMenus());
		mv.addObject("profile", true);
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @param idx
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/{idx}/view", method = RequestMethod.GET)
	public ModelAndView openBoardDetail(Account account, HttpServletRequest request, @PathVariable("idx") int idx) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/user/profile");

		account.setIdx(idx);
		Account detail = accountService.selectMemberDetail(account);
		mv.addObject("map", detail);
		mv.addObject("currentPageNo", account.getCurrentPageNo());

		if (account.getTarget() != null) {
			mv.addObject("target", account.getTarget());
		}
		if (account.getKeyword() != null) {
			mv.addObject("keyword", account.getKeyword());
		}
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/write", method = RequestMethod.GET)
	public ModelAndView adminWrite(Account account,HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mgmt/user/write");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		
		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setPage("json");
		adminMenu.setPid(1);
		List<AdminMenu> adminMenuDetail = adminMenuService.selectMenu(adminMenu);
		mv.addObject("menus", adminMenuDetail);
		List<Map<String, Object>> menuList = JsonUtil.convertorTreeMap(adminMenuDetail, "1", "idx", "parent_idx", "name",null, "sort");
		mv.addObject("mapmenus", menuList);
		

		if (account.getTarget() != null) {
			mv.addObject("target", account.getTarget());
		}
		if (account.getKeyword() != null) {
			mv.addObject("keyword", account.getKeyword());
		}


        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		mv.addObject("toDay", df.format(cal.getTime()));
        cal.add(Calendar.MONTH, 12);
		mv.addObject("fromDay", df.format(cal.getTime()));

		
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return HashMap<String, Object>
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/ajaxProfile", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> openAjaxProfile(Account account, HttpServletRequest request) throws Exception {
		account.setEnabled(true);
		Account detail = accountService.selectMemberDetail(account);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("status", false);
		if(detail!=null){
			map.put("userid", detail.getUserid());
			map.put("name", detail.getName());
			map.put("email", detail.getEmail());
			map.put("department", detail.getDepartment());
			map.put("status", true);
		}
		return map;
	}
	
	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/writeProc")
	public ModelAndView insertAdmin(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/" + adminUrl + "/user");

		String password = new TempKey().getKey(10,false);
		account.setMenus(StringEscapeUtils.unescapeHtml3(account.getMenus()));
		account.setAuthority_name("ROLE_ADMIN");
		account.setPassword(passwordEncoder.encode(password));
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		account.setCrea_id(principal.getUsername());
		account.setCrea_name(principal.getName());
		accountService.insertMember(account);
		

		Account detail = accountService.selectMemberDetail(account);
	    Log logVo = new Log();
	    logVo.setUserid(account.getUserid());
	    logVo.setUsername(account.getName());
	    logVo.setUpdaid(principal.getUserid());
	    logVo.setUpdaname(principal.getName());
	    logVo.setLogin_ip(principal.getLogin_ip());
	    logVo.setGrant_type("계정등록");
	    logVo.setPrev("");
	    if(account.getMenus()==null||account.getMenus()=="") {
	    	logVo.setNext("");
	    }else {
	    	logVo.setNext(account.getMenus());
	    }
		
		
	    logService.insertLogGrant(logVo);
	    
	    String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
		String url = domain+"/mgmt/login?gubun=init";
		HashMap<String,Object> mapMail = new HashMap<String,Object>();
		mapMail.put("TITLE", "임시 비밀번호 안내");
		mapMail.put("PASSWORD", password);
		mapMail.put("TIME", nowTime);
		mapMail.put("ADMINURL", url);
		mapMail.put("domain", domain);
		mapMail.put("adminlink", adminlink);
		MailHandler.getMailSend(mailSender,mailFrom,account.getEmail(),"[계룡 엘리프 관리자] 임시 비밀번호 안내","password",mapMail);
		
		accountService.updateLoginImsi(account);
		
		
		
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @param idx
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/{idx}/modify", method = RequestMethod.GET)
	public ModelAndView memberModify(Account account, HttpServletRequest request, @PathVariable("idx") int idx) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/user/modify");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
		account.setIdx(idx);

		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setPage("json");
		adminMenu.setPid(1);
		List<AdminMenu> adminMenuDetail = adminMenuService.selectMenu(adminMenu);
		mv.addObject("menus", adminMenuDetail);
		List<Map<String, Object>> menuList = JsonUtil.convertorTreeMap(adminMenuDetail, "1", "idx", "parent_idx", "name",null, "sort");
		mv.addObject("mapmenus", menuList);
		
		Account detail = accountService.selectMemberDetail(account);
		// log.info("detail is {}",detail);
		mv.addObject("map", detail);
		mv.addObject("currentPageNo", account.getCurrentPageNo());

		if (account.getTarget() != null) {
			mv.addObject("target", account.getTarget());
		}
		if (account.getKeyword() != null) {
			mv.addObject("keyword", account.getKeyword());
		}
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/modifyProc", method = RequestMethod.POST)
	public ModelAndView memberModifyProc(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/" + adminUrl + "/user");
		Account detailAccount  = new Account();
		detailAccount.setUserid(account.getUserid());
		Account detail = accountService.selectMemberDetail(detailAccount);
		
		if (account.getProfile() != null) {
			if(account.getProfile().equals("true")){
				mv.setViewName("redirect:/" + adminUrl + "/user/profile");
			}
		}
		if (account.getPassword() != null) {
			account.setPassword(passwordEncoder.encode(account.getPassword()));
		}
		account.setMenus(StringEscapeUtils.unescapeHtml3(account.getMenus()));
		account.setWithdraw("N");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		account.setUpda_id(principal.getUsername());
		account.setUpda_name(principal.getName());
		accountService.updateMember(account);
		account.setIdx(principal.getIdx());
		
	    Log logVo = new Log();
	    logVo.setUserid(detail.getUserid());
	    logVo.setUsername(detail.getName());
	    logVo.setUpdaid(principal.getUserid());
	    logVo.setUpdaname(principal.getName());
	    logVo.setLogin_ip(principal.getLogin_ip());
	    logVo.setGrant_type("권한변경");
	    if(detail.getMenus()==null||detail.getMenus()=="") {
	    	logVo.setPrev("");
	    }else {
	    	logVo.setPrev(detail.getMenus());
	    }
	    if(account.getMenus()==null||account.getMenus()=="") {
	    	logVo.setNext("");
	    }else {
	    	logVo.setNext(account.getMenus());
	    }
		if(!logVo.getPrev().equals(logVo.getNext())) {
			logService.insertLogGrant(logVo);	
		}
	    
	    
		// mv.addObject("IDX", commandMap.get("IDX"));
		return mv;
	}

	
	/** 
	 * @param account
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/deleteProc")
	public ModelAndView deleteMember(Account account) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/mgmt/user");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
//		account.setWithdraw("N");
		Account detail = accountService.selectMemberDetail(account);
		accountService.deleteMember(account);
		
	    Log logVo = new Log();
	    logVo.setUserid(detail.getUserid());
	    logVo.setUsername(detail.getName());
	    logVo.setUpdaid(principal.getUserid());
	    logVo.setUpdaname(principal.getName());
	    logVo.setLogin_ip(principal.getLogin_ip());
	    logVo.setGrant_type("계정삭제");
	    if(principal.getMenus()==null||principal.getMenus()=="") {
	    	logVo.setPrev("");
	    }else {
	    	logVo.setPrev(principal.getMenus());
	    }
	    logVo.setNext("");
		
	    logService.insertLogGrant(logVo);
		
		return mv;
	}

	
	/** 
	 * @param request
	 * @param idx
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/{idx}/password-reset", method = RequestMethod.POST)
	public ModelAndView passwordReset( HttpServletRequest request, @PathVariable("idx") int idx) throws Exception {
		ModelAndView mv = new ModelAndView();

		String password = new TempKey().getKey(10,false);
		Account account = new Account();
		account.setIdx(idx);
		Account detail = accountService.selectMemberDetail(account);
		log.info("DETAIL:::::{}",detail);
		Account accountUpdate = new Account();
		accountUpdate.setUserid(detail.getUserid());
		accountUpdate.setPassword(passwordEncoder.encode(password));
		accountService.updateMemberPwd(accountUpdate);
	    
	    String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
		String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
		String url = domain+"/mgmt/login?gubun=init";
		HashMap<String,Object> mapMail = new HashMap<String,Object>();
		mapMail.put("TITLE", "임시 비밀번호 안내");
		mapMail.put("PASSWORD", password);
		mapMail.put("TIME", nowTime);
		mapMail.put("ADMINURL", url);
		mapMail.put("domain", domain);
		mapMail.put("adminlink", adminlink);
		MailHandler.getMailSend(mailSender,mailFrom,detail.getEmail(),"[계룡 엘리프 관리자] 임시 비밀번호 안내","password",mapMail);
		accountService.updateLoginImsi(detail);

		mv.addObject("result", "ok");
		mv.setViewName("jsonView");
		return mv;
	}
	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/password", method = RequestMethod.GET)
	public ModelAndView password(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/" + adminUrl + "/user/password");
		
		return mv;
	}

	
	/** 
	 * @param account
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/password", method = RequestMethod.POST)
	public ModelAndView passwordProc(Account account, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();
		mv.setViewName("redirect:/" + adminUrl + "/user/password");

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();

		account.setUserid(principal.getUserid());
		Account detail = accountService.selectMemberDetail(account);
		String nowPassword = detail.getPassword();

		if ( !passwordEncoder.matches(account.getOld_password(),nowPassword)) {
			session.setAttribute("SITE_ERROR", "입력하신 기존 비밀번호와 현재 비밀번호가 일치하지 않습니다.");
		}else {
			if (!account.getPassword().equals(account.getPassword_comfirm())) {
				session.setAttribute("SITE_ERROR", "입력하신 신규 비밀번호와 신규 비밀번호 확인이 일치하지 않습니다.");
			}else {
				detail.setPassword(passwordEncoder.encode(account.getPassword()));
				detail.setAccountNonLocked(true);

				accountService.updateMemberPwd(detail);
				session.setAttribute("SITE_ALERT", "비밀번호가 변경되었습니다. 다시 로그인해 주세요.");
				mv.setViewName("redirect:/" + adminUrl + "/login");
			}
		}
		
		return mv;
	}
	
	/** 
	 * @param accountIp
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/" + adminUrl + "/user/ip" })
	public ModelAndView memberip(AccountIp accountIp, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/user/ip");

		AccountIp accountIpDetail = (AccountIp) accountService.selectIP(accountIp);
		mv.addObject("clientIP", CommonUtils.getClientIp(request));
		mv.addObject("list", accountIpDetail);
		return mv;
	}

	
	/** 
	 * @param accountIp
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/" + adminUrl + "/user/ip_list" })
	public ModelAndView memberip_list(AccountIp accountIp, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		AccountIp accountIpDetail = (AccountIp) accountService.selectIP(accountIp);
		mv.addObject("list", accountIpDetail);
		mv.addObject("result", "ok");
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param accountIp
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/v/ipDuplicate", method = RequestMethod.POST)
	public ModelAndView memberipSearch(AccountIp accountIp) throws Exception {
		ModelAndView mv = new ModelAndView();
		int main_count = accountService.selectIPSearch(accountIp);
		mv.addObject("COUNT", main_count);
		mv.setViewName("jsonView");
		return mv;
	}

	
	/** 
	 * @param accountIp
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/user/ipProc")
	public ModelAndView memberipProc(AccountIp accountIp, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		if (accountIp.getPage().equals("json")) {
			if (accountIp.getRetype().equals("insert")) {
				int slug_count = accountService.selectIPSearch(accountIp);
				if (slug_count > 0) {
					mv.addObject("result", "dup");
				} else {
					accountService.insertIP(accountIp);
					mv.addObject("result", "ok");
				}

			} else if (accountIp.getRetype().equals("update")) {
				accountService.updateIP(accountIp);
				mv.addObject("result", "ok");
			} else if (accountIp.getRetype().equals("delete")) {
				accountService.deleteIP(accountIp);
				mv.addObject("result", "ok");
			} else {
				mv.addObject("result", "err-type");
			}
		} else {
			mv.addObject("result", "err-page");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
}
