package com.krcon.elif.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.krcon.elif.service.LogService;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.Log;

@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	@Autowired
    private LogService logService;
    
    
	/** 
	 * @param web
	 * @throws Exception
	 */
	@Override
    public void configure(WebSecurity web) throws Exception
    {
        // static 디렉터리의 하위 파일 목록은 인증 무시 ( = 항상통과 )
        web.ignoring().antMatchers("/resources/**","/assets/**", "/upload/**", "/css/**", "/js/**", "/img/**", "/lib/**","/member/join-ipinsms","/m/member/join-ipinsms","/mobile/member/join-ipinsms");
    }

	
	/** 
	 * @param http
	 * @throws Exception
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
        http
			.authorizeRequests()
				.antMatchers("/mgmt/**").hasRole("ADMIN")
				.antMatchers("/**").permitAll()
//				.anyRequest().authenticated()
				.and()
			.formLogin()
				.loginPage("/mgmt/login")
				.loginProcessingUrl("/mgmt/login")
				.defaultSuccessUrl("/mgmt/home")
				.failureHandler(authenticationFailureHandler())
				.usernameParameter("username")
				.permitAll()
				.and()
			.logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/mgmt/logout", "GET"))
	            .addLogoutHandler(logoutHandler())
	            .logoutSuccessUrl("/mgmt/login")
	            .clearAuthentication(true)
	            .invalidateHttpSession(true)
	            .and()
	        .sessionManagement()
                .maximumSessions(1)
                .expiredUrl("/mgmt/login")
                .maxSessionsPreventsLogin(false)
                .sessionRegistry(sessionRegistry());
//		        .and()
//	        .rememberMe()
//		        .key("uniqueAndSecret");
    }
	
	
	/** 
	 * @return PasswordEncoder
	 */
	@Bean
	public PasswordEncoder passwordEncoder(){
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}

    
	/** 
	 * @return AuthenticationFailureHandler
	 */
	@Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new CustomAuthenticationFailureHandler();
    }

    
	/** 
	 * @return LogoutHandler
	 */
	@Bean
    public LogoutHandler logoutHandler() {
        return (request, response, authentication) -> {
    		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    		Account principal = (Account) auth.getPrincipal();
    		principal.setLogin_type("logout");
    		Log logVO = new Log();
    		logVO.setUserid(principal.getUserid());
    		logVO.setName(principal.getName());
    		logVO.setLogin_ip(principal.getLogin_ip());
    		logVO.setLogin_type(principal.getLogin_type());
			try {
				logService.insertLogIn(logVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
        };
    }
    
    
	/** 
	 * @return SessionRegistry
	 */
	@Bean
    public SessionRegistry sessionRegistry() {
        return new SessionRegistryImpl();
    }// Register HttpSessionEventPublisher

	
	/** 
	 * @return ServletListenerRegistrationBean<HttpSessionEventPublisher>
	 */
	@Bean 
	public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() { 
		return new ServletListenerRegistrationBean<HttpSessionEventPublisher>(new HttpSessionEventPublisher()); 
	}

}
