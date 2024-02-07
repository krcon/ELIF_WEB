package com.krcon.elif.controller;

import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class CustomErrorController implements ErrorController {
	private String VIEW_PATH = "";

	Logger log = LoggerFactory.getLogger(this.getClass());
	
	/** 
	 * @param request
	 * @return String
	 */
	@RequestMapping(value = "/error")
	public String handleError(HttpServletRequest request) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		HttpStatus httpStatus = HttpStatus.valueOf(Integer.valueOf(status.toString()));
        // log.info("httpStatus : {}",httpStatus.toString());
        // log.info("code : {}", status.toString());
        // log.info("msg : {}", httpStatus.getReasonPhrase());
        // log.info("timestamp : {}", new Date());


		String request_uri = request.getAttribute("javax.servlet.error.request_uri").toString();
		if(request_uri.indexOf("/mgmt/")==0){
			VIEW_PATH = "mgmt/";
		}else if(request_uri.indexOf("/mobile/")==0){
			VIEW_PATH = "mobile/etc/";
		}else{
			VIEW_PATH = "web/etc/";
		}
		if (status != null) {
			int statusCode = Integer.valueOf(status.toString());
			if (statusCode == HttpStatus.NOT_FOUND.value()) {
				return VIEW_PATH + "error";
			}
			if (statusCode == HttpStatus.FORBIDDEN.value()) {
				return VIEW_PATH + "error";
			}
		}
		return VIEW_PATH + "error";
	}

	
	/** 
	 * @return String
	 */
	@Override
	public String getErrorPath() {
		return null;
	}
}