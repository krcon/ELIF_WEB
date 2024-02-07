package com.krcon.elif.config;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeFilter;
public class CustomXssEscapeServletFilter implements Filter {

	private XssEscapeFilter xssEscapeFilter = XssEscapeFilter.getInstance();

	
	/** 
	 * @param filterConfig
	 * @throws ServletException
	 */
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	
	/** 
	 * @param request
	 * @param response
	 * @param chain
	 * @throws IOException
	 * @throws ServletException
	 */
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		chain.doFilter(new CustomXssEscapeServletFilterWrapper(request, xssEscapeFilter), response);
	}
	
	@Override
	public void destroy() {
	}
}
