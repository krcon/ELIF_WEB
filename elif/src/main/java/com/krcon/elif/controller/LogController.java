package com.krcon.elif.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.krcon.elif.service.AccountService;
import com.krcon.elif.service.AdminMenuService;
import com.krcon.elif.service.LogService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;
import com.krcon.elif.vo.Log;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.pagination.PaginationInfo;


@Controller
public class LogController {
	@Autowired
	AccountService accountService;

	@Autowired
	AdminMenuService adminMenuService;

	@Autowired
	LogService logService;
	
	private final String adminUrl = "mgmt";
	


	
	/** 
	 * @param logVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/log")
	public ModelAndView log_list(Log logVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/log/access");

		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}

    	if("json".equals(logVO.getPage())){
	        List<Log> list = logService.selectLogInList(logVO);
	        mv.addObject("list", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(logVO.getCurrentPageNo());
	        paginationInfo.setRecordCountPerPage(logVO.getRecordCountPerPage());
	        paginationInfo.setPageSize(logVO.getPageSize());
	        int start = paginationInfo.getFirstRecordIndex();
	        int end = paginationInfo.getRecordCountPerPage();
	        
	        int total = logService.selectLogInCount(logVO);
			if(paginationInfo != null){
				paginationInfo.setTotalRecordCount(total);
			}
			logVO.setStart(start);
			logVO.setEnd(paginationInfo.getLastRecordIndex());
	        List<Log> list = logService.selectLogInList(logVO);
	         
	        mv.addObject("paginationInfo", paginationInfo);
	        mv.addObject("list", list);
        }
		
		mv.addObject("currentPageNo", logVO.getCurrentPageNo());
		if (logVO.getTarget() != null) {
			mv.addObject("target", logVO.getTarget());
		}
		if (logVO.getKeyword() != null) {
			mv.addObject("keyword", logVO.getKeyword());
		}
		if (logVO.getSdate() != null) {
			mv.addObject("sdate", logVO.getSdate());
		}

		if (logVO.getEdate() != null) {
			mv.addObject("edate", logVO.getEdate());
		}

		return mv;
	}

	
	/** 
	 * @param logVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/log/menu")
	public ModelAndView log_menu_list(Log logVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/log/menu");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
    	if("json".equals(logVO.getPage())){
	        List<Log> list = logService.selectLogList(logVO);
	        mv.addObject("list", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(logVO.getCurrentPageNo());
	        paginationInfo.setRecordCountPerPage(logVO.getRecordCountPerPage());
	        paginationInfo.setPageSize(logVO.getPageSize());
	        int start = paginationInfo.getFirstRecordIndex();
	        int end = paginationInfo.getRecordCountPerPage();
	        
	        int total = logService.selectLogCount(logVO);
			if(paginationInfo != null){
				paginationInfo.setTotalRecordCount(total);
			}
			logVO.setStart(start);
			logVO.setEnd(paginationInfo.getLastRecordIndex());

	        List<Log> list = logService.selectLogList(logVO);
	         
	        mv.addObject("paginationInfo", paginationInfo);
	        mv.addObject("list", list);
        }
		mv.addObject("currentPageNo", logVO.getCurrentPageNo());
		if (logVO.getTarget() != null) {
			mv.addObject("target", logVO.getTarget());
		}
		if (logVO.getKeyword() != null) {
			mv.addObject("keyword", logVO.getKeyword());
		}
		if (logVO.getSdate() != null) {
			mv.addObject("sdate", logVO.getSdate());
		}

		if (logVO.getEdate() != null) {
			mv.addObject("edate", logVO.getEdate());
		}
		

		return mv;
	}

	
	/** 
	 * @param logVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/log/excel")
	public ModelAndView log_excel_list(Log logVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/log/excel");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}
    	if("json".equals(logVO.getPage())){
	        List<Log> list = logService.selectLogExcelList(logVO);
	        mv.addObject("list", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(logVO.getCurrentPageNo());
	        paginationInfo.setRecordCountPerPage(logVO.getRecordCountPerPage());
	        paginationInfo.setPageSize(logVO.getPageSize());
	        int start = paginationInfo.getFirstRecordIndex();
	        int end = paginationInfo.getRecordCountPerPage();
	        
	        int total = logService.selectLogExcelCount(logVO);
			if(paginationInfo != null){
				paginationInfo.setTotalRecordCount(total);
			}
			logVO.setStart(start);
			logVO.setEnd(paginationInfo.getLastRecordIndex());

	        List<Log> list = logService.selectLogExcelList(logVO);
	         
	        mv.addObject("paginationInfo", paginationInfo);
	        mv.addObject("list", list);
        }
		mv.addObject("currentPageNo", logVO.getCurrentPageNo());
		if (logVO.getTarget() != null) {
			mv.addObject("target", logVO.getTarget());
		}
		if (logVO.getKeyword() != null) {
			mv.addObject("keyword", logVO.getKeyword());
		}
		if (logVO.getKeyword() != null) {
			mv.addObject("keyword", logVO.getKeyword());
		}
		if (logVO.getSdate() != null) {
			mv.addObject("sdate", logVO.getSdate());
		}

		if (logVO.getEdate() != null) {
			mv.addObject("edate", logVO.getEdate());
		}

		return mv;
	}


	
	/** 
	 * @param logVO
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/" + adminUrl + "/grant")
	public ModelAndView log_grant(Log logVO, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/log/grant");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		if(!CommonUtils.checkMenu(principal.getAdminMenu(), request.getServletPath())){
			mv.setViewName("/error");
			return mv;
		}

    	if("json".equals(logVO.getPage())){
	        List<Log> list = logService.selectLogGrantList(logVO);
	        mv.addObject("list", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(logVO.getCurrentPageNo());
	        paginationInfo.setRecordCountPerPage(logVO.getRecordCountPerPage());
	        paginationInfo.setPageSize(logVO.getPageSize());
	        int start = paginationInfo.getFirstRecordIndex();
	        int end = paginationInfo.getRecordCountPerPage();
	        
	        int total = logService.selectLogGrantCount(logVO);
			if(paginationInfo != null){
				paginationInfo.setTotalRecordCount(total);
			}
			logVO.setStart(start);
			logVO.setEnd(paginationInfo.getLastRecordIndex());

	        List<Log> list = logService.selectLogGrantList(logVO);
	         
	        mv.addObject("paginationInfo", paginationInfo);
	        mv.addObject("list", list);
	        
	        AdminMenu adminMenu = new AdminMenu();
	        adminMenu.setPage("json");
	        adminMenu.setPid(1);
	        mv.addObject("listMenu",adminMenuService.selectMenuList(adminMenu));
        }
		mv.addObject("currentPageNo", logVO.getCurrentPageNo());
		if (logVO.getTarget() != null) {
			mv.addObject("target", logVO.getTarget());
		}
		if (logVO.getKeyword() != null) {
			mv.addObject("keyword", logVO.getKeyword());
		}
		if (logVO.getSdate() != null) {
			mv.addObject("sdate", logVO.getSdate());
		}

		if (logVO.getEdate() != null) {
			mv.addObject("edate", logVO.getEdate());
		}
		

		return mv;
	}



	
}
