package com.krcon.elif.config;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import com.krcon.elif.service.AccountService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.MailHandler;
import com.krcon.elif.common.util.TempKey;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	AccountService accountService;

	@Autowired
	public JavaMailSender mailSender;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Value("${sys.mail.address}")
	private String mailFrom;

	@Value("${sys.adminlink}")
    private String adminlink;
	
	/** 
	 * @param request
	 * @param response
	 * @param exception
	 * @throws IOException
	 * @throws ServletException
	 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String token = CommonUtils.getRandomString();
		String userid = request.getParameter("username");
		HttpSession session = request.getSession();
		session.setAttribute("username", userid);
		if (exception.getClass().isAssignableFrom(LockedException.class)) {
			log.info("LOGIN FAILED:::::LockedException");

			Account account = new Account();
			account.setToken(token);
			account.setUserid(userid);
			try {
				accountService.updateToken(account);
			} catch (Exception e) {
				e.printStackTrace();
			}

			setDefaultFailureUrl("/reset/initlock/" + token);
		} else if (exception.getClass().isAssignableFrom(CredentialsExpiredException.class)) {
			log.info("LOGIN FAILED:::::CredentialsExpiredException");
			Account account = new Account();
			account.setToken(token);
			account.setUserid(userid);
			try {
				accountService.updateToken(account);
			} catch (Exception e) {
				e.printStackTrace();
			}
			setDefaultFailureUrl("/reset/credential/" + token);
		} else if (exception.getClass().isAssignableFrom(BadCredentialsException.class)) {
			log.info("LOGIN FAILED:::::BadCredentialsException");
			setDefaultFailureUrl("/mgmt/login");
			Account account = null;
			try {
				account = (Account) accountService.loadUserByUsername(userid);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(account!=null){
				if (account.getLoginFailCnt() < 5) {
					Account accountFail = new Account();
					accountFail.setUserid(userid);
					accountFail.setLoginFailCnt(account.getLoginFailCnt() + 1);
					try {
						accountService.loginFailCnt(accountFail);
					} catch (Exception e) {
						e.printStackTrace();
					}
					;
				} else {
					String pwd = new TempKey().getKey(10, false);
					Account accountUpdate = new Account();
					accountUpdate.setUserid(userid);
					accountUpdate.setPassword(passwordEncoder.encode(pwd));
					try {
						accountService.updateMemberPwd(accountUpdate);
					} catch (Exception e) {
						e.printStackTrace();
					}
					
					String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
					String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
					String url = domain+"/mgmt/login?gubun=init";
					HashMap<String,Object> mapMail = new HashMap<String,Object>();
					mapMail.put("TITLE", "임시 비밀번호 안내");
					mapMail.put("PASSWORD", pwd);
					mapMail.put("TIME", nowTime);
					mapMail.put("ADMINURL", url);
					mapMail.put("domain", domain);
					mapMail.put("adminlink", adminlink);

					log.info(pwd.toString());
					MailHandler.getMailSend(mailSender,mailFrom,account.getEmail(),"[계룡 엘리프 BU 관리자] 임시 비밀번호 안내","password",mapMail);
					try {
						accountService.updateLoginImsi(accountUpdate);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

			}
		} else if (exception.getClass().isAssignableFrom(InsufficientAuthenticationException.class)) {
			
			log.info("LOGIN FAILED:::::InsufficientAuthenticationException");
			setDefaultFailureUrl("/mgmt/login");
			Account account = null;
			try {
				account = (Account) accountService.loadUserByUsername(userid);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String pwd = new TempKey().getKey(10, false);
			Account accountUpdate = new Account();
			accountUpdate.setUserid(userid);
			accountUpdate.setPassword(passwordEncoder.encode(pwd));
			try {
				accountService.updateMemberPwd(accountUpdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String domain = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
			String nowTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분 ss초"));
			String url = domain+"/mgmt/login?gubun=init";
			HashMap<String,Object> mapMail = new HashMap<String,Object>();
			mapMail.put("TITLE", "임시 비밀번호 안내");
			mapMail.put("PASSWORD", pwd);
			mapMail.put("TIME", nowTime);
			mapMail.put("ADMINURL", url);
			mapMail.put("domain", domain);
			mapMail.put("adminlink", adminlink);
			MailHandler.getMailSend(mailSender,mailFrom,account.getEmail(),"[계룡 엘리프 BU 관리자] 임시 비밀번호 안내","password",mapMail);
			try {
				accountService.updateLoginImsi(accountUpdate);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			log.info("LOGIN FAILED:::::OtherException");
			setDefaultFailureUrl("/mgmt/login");
		}

		super.onAuthenticationFailure(request, response, exception);

	}

}