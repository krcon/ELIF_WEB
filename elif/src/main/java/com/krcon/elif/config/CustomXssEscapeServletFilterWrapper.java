package com.krcon.elif.config;


import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.lang3.StringUtils;

import com.navercorp.lucy.security.xss.servletfilter.XssEscapeFilter;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
public class CustomXssEscapeServletFilterWrapper extends HttpServletRequestWrapper {
	private XssEscapeFilter xssEscapeFilter;
	private String path = null;

	Logger log = LoggerFactory.getLogger(this.getClass());

	private static List<String> targetList = Arrays.asList(
	        "vbscript","onblur", "onchange", "onclick", "ondblclick", "enerror",
	        "onfocus", "onload", "onmouse", "expression", "meta", "xml",
	        "onreset", "onmove", "onstop", "onstart",
	        "onresize", "onmousewheel", "ondataavailable",
	        "onafterprint", "onafterupdate", "onmousedown",
	        "onbeforeactivate", "onbeforecopy", "ondatasetchanged",
	        "onbeforedeactivate", "onbeforeeditfocus", "onbeforepaste",
	        "onbeforeprint", "onbeforeunload", "onbeforeupdate",
	        "onpropertychange", "ondatasetcomplete", "oncellchange",
	        "onlayoutcomplete", "onmousemove", "oncontextmenu",
	        "oncontrolselect", "onreadystatechange", "onselectionchange",
	        "onrowsinserted", "onactivae", "oncopy", "oncut", "onbeforecut", "ondeactivate",
	        "ondrag", "ondragend", "ondragenter", "ondragleave", "ondragover", "ondragstart",
	        "ondrop", "onerror", "onerrorupdate", "onfilterchange", "onfinish", "onresizestart",
	        "onunload", "onselectstart", "onfocusin", "onfocusout", "onhelp", "onkeydown",
	        "onkeypress", "onkeyup", "onrowsdelete", "onlosecapture", "onbounce", "onmouseenter",
	        "onmouseleave", "onbefore", "onmouseout", "onmouseover", "onmouseup", "onresizeend",
	        "onabort", "onmoveend", "onmovestart", "onrowenter", "onsubmit", "script"
	);
	

	public CustomXssEscapeServletFilterWrapper(ServletRequest request, XssEscapeFilter xssEscapeFilter) {
		super((HttpServletRequest)request);
		this.xssEscapeFilter = xssEscapeFilter;
		this.path = ((HttpServletRequest)request).getRequestURI();
	}

	
	/** 
	 * @param paramName
	 * @return String
	 */
	@Override
	public String getParameter(String paramName) {
		String value = super.getParameter(paramName);
		return doFilter(paramName, replaceParam(value));
	}

	
	/** 
	 * @param paramName
	 * @return String[]
	 */
	@Override
	public String[] getParameterValues(String paramName) {
		String values[] = super.getParameterValues(paramName);
		if (values == null) {
			return values;
		}
		for (int index = 0; index < values.length; index++) {
			values[index] = doFilter(paramName, replaceParam(values[index]));
		}
		return values;
	}
	
	
	/** 
	 * @return Map<String, String[]>
	 */
	@Override
	public Map<String, String[]> getParameterMap() {
		Map<String, String[]> paramMap = super.getParameterMap();
		Map<String, String[]> newFilteredParamMap = new HashMap<String, String[]>();

		Set<Map.Entry<String, String[]>> entries = paramMap.entrySet();
		for (Map.Entry<String, String[]> entry : entries) {
			String paramName = entry.getKey();
			Object[] valueObj = (Object[])entry.getValue();
			String[] filteredValue = new String[valueObj.length];
			for (int index = 0; index < valueObj.length; index++) {
				filteredValue[index] = doFilter(paramName, String.valueOf(valueObj[index]));
			}
			
			newFilteredParamMap.put(entry.getKey(), filteredValue);
		}

		return newFilteredParamMap;
	}


    
	/** 
	 * @param str
	 * @return String
	 */
	public static String replaceParam(String str) {

        String returnStr = str;

        if (StringUtils.isNotEmpty(str)) {

            String str_low = str.toLowerCase();

            for (String target : targetList) {
                if (str_low.contains(target)) {
                    str = str.replaceAll(target, "xss"+target.replaceAll("on", ""));
                    returnStr = str;
                }
            }
        }

        return returnStr;
    }
	
	/**
	 * @param paramName String
	 * @param value String
	 * @return String
	 */
	private String doFilter(String paramName, String value) {
		return xssEscapeFilter.doFilter(path, paramName, value);
	}
}
