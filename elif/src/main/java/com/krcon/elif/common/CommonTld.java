package com.krcon.elif.common;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.krcon.elif.common.util.JsonUtil;

public class CommonTld {
	@Autowired
	private static Logger log = LoggerFactory.getLogger(CommonTld.class);

	
	/** 
	 * @param youTubeUrl
	 * @return String
	 */
	public static String getYouTubeId(String youTubeUrl) {
		String pattern = "(?<=youtu.be/|watch\\?v=|/videos/|embed\\/)[^#\\&\\?]*";
		Pattern compiledPattern = Pattern.compile(pattern);
		Matcher matcher = compiledPattern.matcher(youTubeUrl);
		if (matcher.find()) {
			return matcher.group();
		} else {
			return "error";
		}
	}

	
	/** 
	 * @param menus
	 * @param menu
	 * @return boolean
	 */
	public static boolean getMenusBool(String menus, String menu) {
		String[] menusArray = menus.split(",");
		boolean menuBool = false;
		for (int i = 0; i < menusArray.length; i++) {
			if (menusArray[i].toString().equals(menu.toString())) {
				menuBool = true;
			}
		}

		return menuBool;
	}


	
	/** 
	 * @param type
	 * @return String
	 */
	public static String getBoardType(String type) {
		String retType = "";
		if(type.equals("news")){
			retType = "뉴스";
		}else if(type.equals("youtube")){
			retType = "유튜브";
		}else if(type.equals("sns")){
			retType = "웹진";
		}

		return retType;
	}
	
	
	/** 
	 * @param name
	 * @return String
	 */
	public static String getMaskedName(String name) {
		String maskedName = ""; // 마스킹 이름
		String firstName = ""; // 성
		String middleName = ""; // 이름 중간
		String lastName = ""; // 이름 끝
		int lastNameStartPoint; // 이름 시작 포인터

		if (!name.equals("") || name != null) {
			if (name.length() > 1) {
				firstName = name.substring(0, 1);
				lastNameStartPoint = name.indexOf(firstName);

				if (name.trim().length() > 2) {
					middleName = name.substring(lastNameStartPoint + 1, name.trim().length() - 1);
					lastName = name.substring(lastNameStartPoint + (name.trim().length() - 1), name.trim().length());
				} else {
					middleName = name.substring(lastNameStartPoint + 1, name.trim().length());
				}

				String makers = "";
				for (int i = 0; i < middleName.length(); i++) {
					makers += "*";
				}

				lastName = middleName.replace(middleName, makers) + lastName;
				maskedName = firstName + lastName;
			} else {
				maskedName = name;
			}
		}

		return maskedName;
	}

	
	/** 
	 * @param phoneNum
	 * @return String
	 */
	public static String getMaskedPhoneNum(String phoneNum) {
		String regex = "^(\\d{3})-?(\\d{3,4})-?(\\d{4})$";
		String replaceString = phoneNum;
	
		Matcher matcher = Pattern.compile(regex).matcher(phoneNum);
	
		if(matcher.matches()) {
			replaceString = "";
	
			boolean isHyphen = false;
			if(phoneNum.indexOf("-") > -1) {
				isHyphen = true;
			}
	
			for(int i=1;i<=matcher.groupCount();i++) {
				String replaceTarget = matcher.group(i);
				if(i == 2) {
					char[] c = new char[replaceTarget.length()];
					Arrays.fill(c, '*');
	
					replaceString = replaceString + String.valueOf(c);
				} else {
					replaceString = replaceString + replaceTarget;
				}
	
				if(isHyphen && i < matcher.groupCount()) {
					replaceString = replaceString + "-";
				}
			}
		}
		return replaceString;
	}

	
	/** 
	 * @param email
	 * @return String
	 */
	public static String getMaskedEmail(String email) {
		/*
		 * 요구되는 메일 포맷 {userId}@domain.com
		 */
		String regex = "\\b(\\S+)+@(\\S+.\\S+)";
		Matcher matcher = Pattern.compile(regex).matcher(email);
		if (matcher.find()) {
			String id = matcher.group(1); // 마스킹 처리할 부분인 userId
			/*
			 * userId의 길이를 기준으로 세글자 초과인 경우 뒤 세자리를 마스킹 처리하고, 세글자인 경우 뒤 두글자만 마스킹, 세글자 미만인 경우
			 * 모두 마스킹 처리
			 */
			int length = id.length();
			if (length < 3) {
				char[] c = new char[length];
				Arrays.fill(c, '*');
				return email.replace(id, String.valueOf(c));
			} else if (length == 3 || length == 4) {
				return email.replaceAll("\\b(\\S+)[^@][^@]+@(\\S+)", "$1**@$2");
			} else {
				return email.replaceAll("\\b(\\S+)[^@][^@][^@]+@(\\S+)", "$1***@$2");
			}
		}
		return email;
	}
	
	/** 
	 * @param listMenu
	 * @param roleMenu
	 * @return List
	 * @throws JsonMappingException
	 * @throws JsonProcessingException
	 */
	@SuppressWarnings("rawtypes")
	public static List getJsonToList(List listMenu,String roleMenu) throws JsonMappingException, JsonProcessingException {
		List<Map<String, Object>> menuList = null;
		if(roleMenu==""||roleMenu==null) {
			return menuList;
		}
		System.out.println(">>>>>>>>>>"+listMenu);
		menuList = JsonUtil.convertorTreeMap(listMenu, "1", "idx", "parent_idx", "name",roleMenu, null);
		return menuList;
	}
	
	/** 
	 * @param listMenu
	 * @param roleMenu
	 * @return String
	 * @throws JsonMappingException
	 * @throws JsonProcessingException
	 */
	@SuppressWarnings("rawtypes")
	public static String getJsonToHtml(List listMenu,String roleMenu) throws JsonMappingException, JsonProcessingException {
		List<Map<String, Object>> menuList = null;
		if(roleMenu==""||roleMenu==null) {
			return "";
		}
		String retHtml = "";
		menuList = JsonUtil.convertorTreeMap(listMenu, "1", "idx", "parent_idx", "name",roleMenu, null);
        for ( int menuCnt=0; menuCnt<menuList.size(); menuCnt++ ) {
        	retHtml +="<ul>";
            Map<String, Object> item = menuList.get(menuCnt);
			@SuppressWarnings("unchecked")
            List<Map<String, Object>> childrenList = (List<Map<String, Object>>) item.get("children");
            if(childrenList.size()>0) {
	            for ( int childCnt=0; childCnt<childrenList.size(); childCnt++ ) {
	                Map<String, Object> item2 = childrenList.get(childCnt);
					retHtml +="<li>[";
					retHtml +="<span class='head'>"+item.get("title")+"</span>,";
	                retHtml +="<span class='body'>"+item2.get("title")+"</span>";         
					retHtml +="]</li>";
                }
            }
            retHtml +="</ul>";
            
        }
		return retHtml;
	}
	
	/** 
	 * @param input
	 * @return String
	 * @throws UnsupportedEncodingException
	 */
	public static String getUrlDecode(String input) throws UnsupportedEncodingException {
		input = input.replaceAll("%", "%25");
		return URLDecoder.decode(input, "UTF-8");
	}

	
	/** 
	 * @param input
	 * @return String
	 * @throws UnsupportedEncodingException
	 */
	public static String getXssDecode(String input) throws UnsupportedEncodingException {
		String str = input;
		str = str.replaceAll("&lt;", "<");
		str = str.replaceAll("&gt;", ">");
		str = str.replaceAll("&amp;&quot;", "\'");
		str = str.replaceAll("&amp;quot;", "\'");
		str = str.replaceAll("&quot;", "\"");
		str = str.replaceAll("&nbsp;", " ");
		str = str.replaceAll("&amp;", "&");
		str = str.replaceAll("&amp;nbsp;", " ");
		return str;
	}

	
	/** 
	 * @param str
	 * @return String
	 */
	public static String nl2br(String str) {
		str = str.replaceAll("\r\n", "<br>");
		str = str.replaceAll("\r", "<br>");
		str = str.replaceAll("\n", "<br>");
		
		return str;
	}

	
	/** 
	 * @param str
	 * @return String[]
	 */
	public static String[] shuffle(String str){    
		String[] arr = str.split(",");

		for(int x=0;x<arr.length;x++){
			int i = (int)(Math.random()*arr.length);
			int j = (int)(Math.random()*arr.length);

			String tmp = arr[i];
			arr[i] = arr[j];
			arr[j] = tmp;
		}
		return arr;
	}
}
