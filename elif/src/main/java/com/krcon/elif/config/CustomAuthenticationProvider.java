package com.krcon.elif.config;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Component;

import com.krcon.elif.common.util.JsonUtil;
import com.krcon.elif.service.AccountService;
import com.krcon.elif.service.AdminMenuService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	private AccountService accountService;

	@Autowired
	AdminMenuService adminService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	private Logger log = LoggerFactory.getLogger(this.getClass());

	
	/** 
	 * @param authentication
	 * @return Authentication
	 * @throws AuthenticationException
	 */
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {

		log.info("### authenticate ### ");
		
		String username = (String) authentication.getPrincipal();
		String password = (String) authentication.getCredentials();
		Object details = authentication.getDetails();
		String remoteAddress = null;
        if (details instanceof WebAuthenticationDetails) {
            remoteAddress = ((WebAuthenticationDetails) details).getRemoteAddress(); 
        }
		Account account = null;
		try {
			account = (Account) accountService.loadUserByUsername(username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(account == null){
			throw new BadCredentialsException("아이디나 비밀번호가 맞지 않습니다.");
		}
		

		

        Calendar cal = Calendar.getInstance();
        Date nowDate = new Date();
        
        Date imsiDate = account.getImsi_dtm();
        if(imsiDate!=null) {
        	cal.setTime(imsiDate);
        	cal.add(Calendar.DATE, 1);
            int compare = cal.getTime().compareTo( nowDate );
        	log.info("cal.getTime {}",cal.getTime());
        	log.info("nowDate {}",nowDate);
            if ( compare < 0 ) {
            	throw new InsufficientAuthenticationException("임시 비밀번호 사용 기간(24시간)이 초과 되었습니다.\n등록하신 이메일로 임시 비밀번호가 재발송되었습니다.\n확인 후 로그인하세요.");
            }
        }
		
        Date oriDate = account.getPass_dtm();
        if(oriDate!=null) {
        	cal.setTime(oriDate);
        	cal.add(Calendar.DATE, 90);
            int compare = cal.getTime().compareTo( nowDate );
            if ( compare < 0 )
            {
            	try {
            		account.setCredentialsNonExpired(false);
	            	// if(accountService.updateCredential(account)>-1) {
	            	// 	account.setCredentialsNonExpired(false);
	            	// }
	            	
				} catch (Exception e) {
					e.printStackTrace();
				}
            }
        }
        
        Calendar calStart = Calendar.getInstance();
        Calendar calEnd = Calendar.getInstance();
        Date startDate = account.getStart_dtm();
        Date endDate = account.getEnd_dtm();

        if(startDate!=null&&endDate!=null) {
        	calStart.setTime(startDate);
        	calEnd.setTime(endDate);
        	
            int startCt = calStart.getTime().compareTo( nowDate );
            int endCt = calEnd.getTime().compareTo( nowDate );
            if(startCt >= 0 || endCt < 0) {
            	try {
	            	account.setAccountNonExpired(false);
				} catch (Exception e) {
					e.printStackTrace();
				}
            }
        }
        
        
		// pw같은지 검증.
		if ( !passwordEncoder.matches(password,account.getPassword())) { // 패스워드가 맞는지 확인
			if (account.getLoginFailCnt() < 5) {
				throw new BadCredentialsException("아이디나 비밀번호가 맞지 않습니다.\n다시 확인해주세요.");
			} else {
				throw new BadCredentialsException("비밀번호 5회 이상 오류입니다.\n등록하신 이메일로 임시 비밀번호가 발송되었습니다.\n확인 후 로그인하세요.");
			}
		}else if(!account.isEnabled()) { // 계정 활성화여부 확인
			throw new DisabledException("계정이 비활성화되었습니다.\n관리자에게 문의하세요.");
		}else if(!account.isAccountNonExpired()) { // 만료되었는지 확인
			throw new AccountExpiredException("해당 계정의 사용 기간이 만료되었습니다. \n관리 담당자에게 문의하세요.");
		}else if(!account.isAccountNonLocked()) { // 계정 잠금되었는지 확인
			throw new LockedException("계정이 잠겨있습니다.\n관리자에게 문의하세요.");
		}else if(!account.isCredentialsNonExpired()) { // 패스워드가 만료되었는지 확인
			throw new CredentialsExpiredException("비밀번호 유효기간이 만료 되었습니다.\n관리자에게 문의하세요."); 
		}
		try {
			account.setLogin_ip(remoteAddress);
			account.setLogin_type("login");
			accountService.loginCnt(account);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		AdminMenu adminMenu = new AdminMenu();
		adminMenu.setPage("json");
		adminMenu.setPid(1);
		
		List<AdminMenu> adminMenuList = null;
		try {
			adminMenuList = adminService.selectMenuList(adminMenu);
			// log.info("adminMenuList:::",adminMenuList);
			account.setAllMenu(adminMenuList);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String roleMenu = null;
		if(!account.getGrants().equals("ROLE_ADMIN")) {
			roleMenu = account.getMenus();
		}
		List<Map<String, Object>> menuList;
		try {
			menuList = JsonUtil.convertorTreeMap(adminMenuList, "1", "idx", "parent_idx", "name",roleMenu, "sort");
			account.setAdminMenu(menuList);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return new UsernamePasswordAuthenticationToken(account, account, account.getAuthorities());
		
	}


	
	/** 
	 * @param authentication
	 * @return boolean
	 */
	@Override
	public boolean supports(Class<?> authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}

}