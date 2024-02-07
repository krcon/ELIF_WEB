package com.krcon.elif.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.JsonUtil;
import com.krcon.elif.service.AccountService;
import com.krcon.elif.service.AdminMenuService;
import com.krcon.elif.service.BoardService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@RequestMapping(value = "mgmt")
@Controller
public class AdminController {
	@Autowired
	AccountService accountService;

	@Autowired
	AdminMenuService adminService;

	@Autowired
	BoardService boardService;
	
	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Value("${sys.code.authsec}")
    private String authsec;
	
	@Autowired
	private RequestMappingHandlerMapping requestMappingHandlerMapping;

	private final Logger log = LoggerFactory.getLogger(this.getClass());

	
	/** 
	 * @return ModelAndView
	 */
	// @RequestMapping(value = "/", method = RequestMethod.GET)
	// public ModelAndView index(HttpServletRequest req) {
	// 	ModelAndView mv = new ModelAndView();
	// 	mv.setViewName("redirect:/" + adminUrl + "/home");
	// 	return mv;
	// }
	

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView admin_home(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("mgmt/home/index");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		log.info(principal.getUsername()+"님이 로그인 했습니다.");
		
		if(CommonUtils.isAuthsec(principal.getAuthsec_dtm(),authsec)){
			response.sendRedirect("/mgmt/anon/authsec");
		}
		return mv;

	}
	

	
	/** 
	 * @param adminMenu
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = { "/menu/list" })
	public ModelAndView menu(AdminMenu adminMenu, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("/mgmt/home/menu");
		adminMenu.setPage("json");
		adminMenu.setPid(0);
		List<AdminMenu> detail = (List<AdminMenu>) adminService.selectMenu(adminMenu);
		List<Map<String, Object>> menuList = JsonUtil.convertorTreeMap(detail, "1", "idx", "parent_idx", "name",null, "sort");
		mv.addObject("list", menuList);
		
		return mv;
	}

	
	/** 
	 * @param adminMenu
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/menu/proc")
	public ModelAndView menuProc(AdminMenu adminMenu, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		
		adminMenu.setUserid(principal.getUsername());
		
		if (adminMenu.getPage().equals("json")) {
			if (adminMenu.getRetype().equals("insert")) {
				int retMenu = adminService.insertMenu(adminMenu);
				if(retMenu>0) {
					mv.addObject("result", "ok");	
				}else {
					mv.addObject("result", "error");
				}
				

			} else if (adminMenu.getRetype().equals("update")) {
				int retMenu = adminService.updateMenu(adminMenu);
				if(retMenu>0) {
					mv.addObject("result", "ok");	
				}else {
					mv.addObject("result", "error");
				}
			} else if (adminMenu.getRetype().equals("delete")) {
				int retMenu = adminService.deleteMenu(adminMenu);
				if(retMenu>0) {
					mv.addObject("result", "ok");	
				}else {
					mv.addObject("result", "error");
				}
			} else {
				mv.addObject("result", "err-type");
			}

			List<AdminMenu> adminMenuList = null;
			try {
				adminMenuList = adminService.selectMenuList(adminMenu);
				// log.info("adminMenuList:::",adminMenuList);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			String roleMenu = null;
			if(!principal.getGrants().equals("ROLE_ADMIN")) {
				roleMenu = principal.getMenus();
			}
			List<Map<String, Object>> menuList;
			try {
				menuList = JsonUtil.convertorTreeMap(adminMenuList, "1", "idx", "parent_idx", "name",roleMenu, "sort");
				principal.setAdminMenu(menuList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			mv.addObject("result", "err-page");
		}
		mv.setViewName("jsonView");
		return mv;
	}


	
	
	/** 
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatemenu")
	public ModelAndView updateMenuProc(HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("redirect:/mgmt/home");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Account principal = (Account) auth.getPrincipal();
		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setUserid(principal.getUsername());
		
		List<AdminMenu> adminMenuList = null;
		try {
			adminMenuList = adminService.selectMenuList(adminMenu);
			// log.info("adminMenuList:::",adminMenuList);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String roleMenu = null;
		if(!principal.getGrants().equals("ROLE_ADMIN")) {
			roleMenu = principal.getMenus();
		}
		List<Map<String, Object>> menuList;
		try {
			menuList = JsonUtil.convertorTreeMap(adminMenuList, "1", "idx", "parent_idx", "name",roleMenu, "sort");
			principal.setAdminMenu(menuList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mv;
	}
	
	
	
	/** 
	 * @param req
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/etc/endpoint", method = RequestMethod.GET)
	public ModelAndView ezndpoint(HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		mv.addObject( "endPoints", requestMappingHandlerMapping.getHandlerMethods().keySet() );
		
		mv.setViewName("mgmt/home/endpoint");
		return mv;
	}
}
