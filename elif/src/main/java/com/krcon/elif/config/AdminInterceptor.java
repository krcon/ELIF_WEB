package com.krcon.elif.config;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;

@Configuration
@PropertySource("classpath:system.properties")

@SuppressWarnings("deprecation")
@Component
public class AdminInterceptor extends HandlerInterceptorAdapter {
	@Value("${sys.code.authsec}")
    private String authsec;
	
	Logger log = LoggerFactory.getLogger(this.getClass());

	
	/** 
	 * @param request
	 * @param response
	 * @param handler
	 * @return boolean
	 * @throws Exception
	 */
	//controller로 보내기 전 이벤트 작동(false - controller로 요청을 안함)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		log.info("============================== INTERCEPTOR START ==============================");
		log.info(" LOG \t:  " + authsec);
		
		if(request.getServletPath().indexOf("/mgmt")>-1){
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			if(!auth.getPrincipal().equals("anonymousUser")) {
				Account principal = (Account) auth.getPrincipal();
				principal.setRequested_menu(request.getRequestURI());
				if(CommonUtils.isAuthsec(principal.getAuthsec_dtm(),authsec)){
					response.sendRedirect("/mgmt/anon/authsec");
					return false;
				}
				
			}
		}
		
		log.info("=============================== INTERCEPTOR END   ============================== ");
		
		return super.preHandle(request, response, handler);
	}
	
	
	/** 
	 * @param request
	 * @param response
	 * @param handler
	 * @param modelAndView
	 * @throws Exception
	 */
	//controller 처리 이후 이벤트 작동
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		log.info("Interceptor > postHandle");
		HandlerMethod handlerMethod = (HandlerMethod) handler;
		String controllerName = handlerMethod.getBeanType().getSimpleName();
		if(controllerName!=null){
			log.info("Controller Name : {}",controllerName);
		}
		if(modelAndView != null){
			String viewName = modelAndView.getViewName();
			log.info("View Name : {}",viewName);

			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			
			if(auth.isAuthenticated()){
				Account principal = (Account) auth.getPrincipal();
				boolean pageGrant = false;
				String pageName = request.getRequestURI().replace("_list","");
				String referer = (String)request.getHeader("REFERER");
				for(AdminMenu menus : principal.getAllMenu()){
					String menuName = menus.getUrl().replace("_list","").replace("_write","").replace("_modify","");
					if(pageName.replace("_list","").indexOf(menuName)>-1){
						pageGrant=true;
					}
				}
				if(pageGrant==false){
					response.sendRedirect(referer);
				}
			}
		}else{
			log.info("View is null");
		}
	}
	
	
	/** 
	 * @param request
	 * @param response
	 * @param handler
	 * @param ex
	 * @throws Exception
	 */
	//view 처리 이후 이벤트 작동
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		log.info("================================ END ================================");
	}
}