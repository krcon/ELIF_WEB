package com.krcon.elif.common.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.krcon.elif.common.CommandMap;
import com.krcon.elif.common.CommonTld;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class CommonUtils {

    private static String password = "krconelifsecret";

    private static String algorithm = "PBEWithMD5AndDES";
	

	private static Logger log = LoggerFactory.getLogger(CommonUtils.class);

	
	/** 
	 * @return String
	 */
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

	
	/** 
	 * @param reader
	 * @return String
	 * @throws IOException
	 */
	private static String jsonReadAll(Reader reader) throws IOException {
		StringBuilder sb = new StringBuilder();
		int cp;
		while ((cp = reader.read()) != -1) {
			sb.append((char) cp);
		}
		return sb.toString();
	}

	
	/** 
	 * @param array
	 * @return String
	 */
	public static String toCSV(String[] array) {
		String result = "";

		if (array.length > 0) {
			StringBuilder sb = new StringBuilder();

			for (String s : array) {
				sb.append(s).append(",");
			}

			result = sb.deleteCharAt(sb.length() - 1).toString();
		}
		return result;
	}
	
	/** 
	 * @param request
	 * @param sessionid
	 * @return boolean
	 */
	public static boolean logincheck(HttpServletRequest request,String sessionid){
		HttpSession session = request.getSession();
		if(CommonUtils.isEmpty(session.getAttribute(sessionid))){
			return false;
		}else{
			return true;
		}
		
	}
	
	/** 
	 * @param authsec_dtm
	 * @param authsec
	 * @return boolean
	 * @throws ParseException
	 */
	public static boolean isAuthsec(Date authsec_dtm, String authsec) throws ParseException{
		boolean authsecBool = false;
		log.info("authsec:::"+authsec);
		log.info(System.getProperty("sys.code.authsec"));
		if(authsec.equals("Y")) {
			if(authsec_dtm==null) {
				authsecBool = true;
			}else {
				SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd");
				Date nowDate = new Date();
				String current = format.format(nowDate);
				Date today = format.parse(current);
				Date oriDate = authsec_dtm;
				log.info("oriDate::::"+oriDate);
				String current2 = format.format(oriDate);
				Date end = format.parse(current2);
				if(today.compareTo(end)!=0) {
					authsecBool = true;
				}
			}
			log.info("nowDate:::"+authsecBool);
		}
		return authsecBool;
	}
	
	/** 
	 * @param url
	 * @return Map<String, Object>
	 * @throws IOException
	 */
	public static Map<String, Object> readJsonFromUrl(String url) throws IOException {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		InputStream is = new URL(url).openStream();
		try {
			// log.info("------------------------------------------------->"+url);
			BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
			String jsonText = jsonReadAll(rd);
			@SuppressWarnings("unchecked")
			HashMap<String, Object> rs = new ObjectMapper().readValue(jsonText.toString(), HashMap.class);
			// log.info(rs);
			returnMap.put("result", rs);
		} finally {
			is.close();
		}
		return returnMap;
	}
	
	/** 
	 * @param utcLongDateTime
	 * @return String
	 */
	public static String fbDateFormat(String utcLongDateTime) {
		SimpleDateFormat fb_dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ssZZZZZ");
		SimpleDateFormat my_dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String localDateString = null;
		long when = 0;
		try {
			when = fb_dateFormat.parse(utcLongDateTime).getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		localDateString = my_dateFormat.format(new Date(when + TimeZone.getDefault().getRawOffset()
				+ (TimeZone.getDefault().inDaylightTime(new Date()) ? TimeZone.getDefault().getDSTSavings() : 0)));
		return localDateString;
	}

	
	/** 
	 * @param utcLongDateTime
	 * @return String
	 */
	public static String instaDateFormat(String utcLongDateTime) {
		SimpleDateFormat my_dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String localDateString = null;
		long when = Long.parseLong(utcLongDateTime) * 1000;
		localDateString = my_dateFormat.format(new Date(when + TimeZone.getDefault().getRawOffset()
				+ (TimeZone.getDefault().inDaylightTime(new Date()) ? TimeZone.getDefault().getDSTSavings() : 0)));
		return localDateString;
	}

	
	/** 
	 * @param list
	 * @param keyNm
	 */
	public static void listSort(List<Map<String, Object>> list, String keyNm) {
		listSort(list, keyNm, false);
	}

	
	/** 
	 * @param list
	 * @param keyNm
	 * @param descOrder
	 */
	public static void listSort(List<Map<String, Object>> list, String keyNm, boolean descOrder) {
		Comparator<Map<String, Object>> comparator = new ListMapComparator(keyNm);
		Collections.sort(list, comparator);

		if (descOrder) {
			Collections.reverse(list);
		}
	}
	
	/** 
	 * @param map
	 * @return String
	 */
	public static String urlEncodeUTF8(Map<?,?> map) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<?,?> entry : map.entrySet()) {
            if (sb.length() > 0) {
                sb.append("&");
            }
            sb.append(String.format("%s=%s",
                urlEncodeUTF8(entry.getKey().toString()),
                urlEncodeUTF8(entry.getValue().toString())
            ));
        }
        return sb.toString();       
    }
	
	/** 
	 * @param s
	 * @return String
	 */
	static String urlEncodeUTF8(String s) {
        try {
            return URLEncoder.encode(s, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new UnsupportedOperationException(e);
        }
    }
	
	/** 
	 * @param str
	 * @return int
	 */
	// 문자 바이이트 체크 부분....
	public static int GetMessageBytes(String str) {
		int wLen = 0;
		int charat;

		for (int i = 1; i < str.length(); i++) {
			charat = str.charAt(i);
			if (charat > 0 && charat < 255) {
				wLen = wLen + 1;
			} else {
				wLen = wLen + 2;
			}
		}

		return wLen;
	}

	/**
	 * Null 체크함수
	 * 
	 * @param String str - 리턴될 문자열 만약 null이면 공백을 반환한다.
	 * @return String 결과
	 */
	public static String nullCheck(String str) {
		if (null == str || str.equals(null) || str == "" || str.equals("") || str == "null")
			return "";
		else
			return str.trim();
	}

	/**
	 * Null 체크함수
	 * 
	 * @param String str - 리턴될 문자열 만약 null이면 공백을 반환한다.
	 * @return String 결과
	 */
	public static String nullCheckObject(Object obj) {
		if (obj == null)
			return "";
		else
			return obj.toString().trim();
	}

	/**
	 * Null 체크함수
	 * 
	 * @param Object obj - 리턴될 문자열 만약 null이면 FALSE를 반환한다.
	 * @return boolean 결과
	 */
	public static boolean isEmpty(Object obj) {
		if (obj == null)
			return true;
		if ((obj instanceof String) && (((String) obj).trim().length() == 0)) {
			return true;
		}
		if (obj instanceof Map) {
			return ((Map<?, ?>) obj).isEmpty();
		}
		if (obj instanceof Map) {
			return ((Map<?, ?>) obj).isEmpty();
		}
		if (obj instanceof List) {
			return ((List<?>) obj).isEmpty();
		}
		if (obj instanceof Object[]) {
			return (((Object[]) obj).length == 0);
		}

		return false;
	}

	
	/** 
	 * @param paramValue
	 * @param gubun
	 * @return String
	 */
	public static String requestReplace(String paramValue, String gubun) {
		String result = "";

		if (paramValue != null) {

			paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

			paramValue = paramValue.replaceAll("\\*", "");
			paramValue = paramValue.replaceAll("\\?", "");
			paramValue = paramValue.replaceAll("\\[", "");
			paramValue = paramValue.replaceAll("\\{", "");
			paramValue = paramValue.replaceAll("\\(", "");
			paramValue = paramValue.replaceAll("\\)", "");
			paramValue = paramValue.replaceAll("\\^", "");
			paramValue = paramValue.replaceAll("\\$", "");
			paramValue = paramValue.replaceAll("'", "");
			paramValue = paramValue.replaceAll("@", "");
			paramValue = paramValue.replaceAll("%", "");
			paramValue = paramValue.replaceAll(";", "");
			paramValue = paramValue.replaceAll(":", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll("#", "");
			paramValue = paramValue.replaceAll("--", "");
			paramValue = paramValue.replaceAll("-", "");
			paramValue = paramValue.replaceAll(",", "");

			if (gubun != "encodeData") {
				paramValue = paramValue.replaceAll("\\+", "");
				paramValue = paramValue.replaceAll("/", "");
				paramValue = paramValue.replaceAll("=", "");
			}

			result = paramValue;

		}
		return result;
	}

	
	/** 
	 * @param mapSession
	 * @return String
	 */
	public static String redirectAdmin(Map<String, Object> mapSession) {
		String returnValue = "/mgmt/user/modify.do?IDX=" + mapSession.get("ADMIN_ID").toString();
		if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), "1") == true) {
			returnValue = "/mgmt/user/list";
		} else if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), "2") == true) {
			returnValue = "/mgmt/board/list.do?PID=2";
		} else if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), "3") == true) {
			returnValue = "/mgmt/company/list";
		} else if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), "4") == true) {
			returnValue = "/mgmt/board/list.do?PID=7";
		} else if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), "5") == true) {
			returnValue = "/mgmt/board/list?PID=10";
		}
		return returnValue;
	}

	
	/** 
	 * @param mapSession
	 * @param menus
	 * @return boolean
	 */
	public static boolean checkAdmin(Map<String, Object> mapSession, String menus) {
		boolean returnValue = true;
		if (!mapSession.get("GRANTS").toString().equals("Y")) {
			if (CommonTld.getMenusBool(mapSession.get("MENUS").toString(), menus) == false) {
				returnValue = false;
			}
		}
		return returnValue;
	}

	
	/** 
	 * @param stringToCheck
	 * @param radix
	 * @return boolean
	 */
	public static boolean isStringInteger(String stringToCheck, int radix) {
		if (stringToCheck.isEmpty())
			return false; // Check if the string is empty
		for (int i = 0; i < stringToCheck.length(); i++) {
			if (i == 0 && stringToCheck.charAt(i) == '-') { // Check for negative Integers
				if (stringToCheck.length() == 1)
					return false;
				else
					continue;
			}
			if (Character.digit(stringToCheck.charAt(i), radix) < 0)
				return false;
		}
		return true;
	}

	
	/** 
	 * @param adminMenu
	 * @param thisMenu
	 * @return boolean
	 */
	public static boolean checkMenu(List<Map<String, Object>> adminMenu, String thisMenu) {
		boolean retBool = false;
		for (Map<String, Object> menus : adminMenu) {
			if (menus.get("children") != null && retBool == false) {
				if (menus.get("children").getClass().getName().indexOf("ArrayList") > -1) {
					@SuppressWarnings("unchecked")
					List<HashMap<String, Object>> objects = (List<HashMap<String, Object>>) menus.get("children");
					for (Map<String, Object> submenus : objects) {
						if (submenus.get("url") != null) {
							if(thisMenu.replace("/partner","/qna").replace("/general","/qna").indexOf(submenus.get("url").toString()) > -1){
								retBool = true;
							}
						}

					}
				}
			}
		}
		return retBool;
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
	 * @param map
	 * @param objClass
	 * @return Object
	 */
	public static Object convertMapToObject(Map<?, ?> map, Object objClass) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;

		@SuppressWarnings("rawtypes")
		Iterator itr = map.keySet().iterator();
		while (itr.hasNext()) {
			keyAttribute = (String) itr.next();
			boolean isSec = false;
		    /**
		    * 스프링 시큐리티 관련 필드 해제 
		    */
			if( keyAttribute.equals("isAccountNonExpired") ||
				keyAttribute.equals("isAccountNonLocked") ||
				keyAttribute.equals("isCredentialsNonExpired") ||
				keyAttribute.equals("isEnabled")
			  ) {
				String oldKeyAttribute = keyAttribute.replace("is", "");
				methodString = setMethodString + oldKeyAttribute.substring(0, 1).toUpperCase() + oldKeyAttribute.substring(1);
				isSec = true;
			}else {
				methodString = setMethodString + keyAttribute.substring(0, 1).toUpperCase() + keyAttribute.substring(1);
			}
			
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				for (int i = 0; i <= methods.length - 1; i++) {
					if (methodString.equals(methods[i].getName())) {
						if(isSec == true){
							methods[i].invoke(objClass, Boolean.valueOf(map.get(keyAttribute).toString()).booleanValue());
						}else {
							methods[i].invoke(objClass, map.get(keyAttribute));
						}
						
					}
				}
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return objClass;
	}
    
	/** 
	 * @param request
	 * @return String
	 */
	public static String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("Proxy-Client-IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("WL-Proxy-Client-IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("HTTP_CLIENT_IP");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getHeader("HTTP_X_FORWARDED_FOR");
         }
         if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
             ip = request.getRemoteAddr();
         }
         return ip;
    }
	
	/** 
	 * @param fileName
	 * @param type
	 * @return boolean
	 * @throws Exception
	 */
	public static boolean isPermissionFileExt( String fileName , String type) throws Exception {
		
		List<String> PERMISSION_FILE_EXT_ARR = Arrays.asList("GIF", "JPEG", "JPG", "PNG", "BMP", "PDF", "MP4", "DOC", "DOCX", "PDF", "XLS", "XLSX", "CSV", "PPT", "PPTX");
		if(type.equals("thumb")){
			PERMISSION_FILE_EXT_ARR = Arrays.asList("GIF", "JPEG", "JPG", "PNG");
		}else if(type.equals("pdf")){
			PERMISSION_FILE_EXT_ARR = Arrays.asList("PDF");
		}
		
		if( !StringUtils.hasText(fileName) ) {
			return false;
		}
		
		String[] fileNameArr = fileName.split("\\.");
		
		if( fileNameArr.length == 0 ) {
			return false;
		}
		
		String ext = fileNameArr[fileNameArr.length - 1].toUpperCase();
		 
		boolean isPermissionFileExt = false;
		
		for( String item : PERMISSION_FILE_EXT_ARR ) {
			if( item.equals(ext) ) {
				isPermissionFileExt = true;
				break;
			}
		}
		
		return isPermissionFileExt;
		
	}
	
	/** 
	 * @param request
	 * @return boolean
	 * @throws Exception
	 */
	public static boolean checkFileExtension(HttpServletRequest request) throws Exception{
	    MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
	    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
	   
	    boolean returnBool=true;
	    MultipartFile multipartFile = null;
	    while(iterator.hasNext()){
	        multipartFile = multipartHttpServletRequest.getFile((String)iterator.next());
	        if(multipartFile.isEmpty() == false){

				String fileSection = "";
				if(multipartFile.getName().indexOf("_")>-1){
					fileSection = multipartFile.getName().split("_")[0];
				}
				
	        	if(!isPermissionFileExt(multipartFile.getOriginalFilename(),fileSection)) {
	        		returnBool=false;
	        	}
	        }
	        log.info("UPLOAD");
	    }
	    return returnBool;
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
	 * DIGEST ALGORITHMS:   [MD2, MD5, SHA, SHA-256, SHA-384, SHA-512]
	 *  PBE ALGORITHMS:      [PBEWITHMD5ANDDES, PBEWITHMD5ANDTRIPLEDES, PBEWITHSHA1ANDDESEDE, PBEWITHSHA1ANDRC2_40]
	 */
	public static String encrypt(String str){
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		encryptor.setPassword(password);
		encryptor.setAlgorithm(algorithm);
		// encryptor.setSaltGenerator(new StringFixedSaltGenerator("someFixedSalt"));
		return encryptor.encrypt(str);
	}
	
	/** 
	 * @param str
	 * @return String
	 */
	public static String decrypt(String str){
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		str = str.replace(" ", "+");
		encryptor.setPassword(password);
		encryptor.setAlgorithm(algorithm);
		// encryptor.setSaltGenerator(new StringFixedSaltGenerator("someFixedSalt"));
		return encryptor.decrypt(str);
	}

	
	/** 
	 * @param request
	 * @param page
	 * @return Map<String, Object>
	 */
	public static Map<String,Object> niceIdReq(HttpServletRequest request,String page){

		String baseUrl = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

		String sSiteCode = "G3616"; // NICE로부터 부여받은 사이트 코드
		String sSitePassword = "E6KE7HOCC3UC"; // NICE로부터 부여받은 사이트 패스워드

		String sRequestNumber = "REQ0000000001"; // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로
													// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
		sRequestNumber = niceCheck.getRequestNO(sSiteCode);

		request.getSession().setAttribute("sREQ_SEQ", sRequestNumber); // 본인인증
		String sAuthType = ""; // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서

		String popgubun = "N"; // Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize = ""; // 없으면 기본 웹페이지 / Mobile : 모바일페이지

		String sGender = ""; // 없으면 기본 선택 값, 0 : 여자, 1 : 남자

		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		// 리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url :
		// http://www.~
		String sReturnUrl = baseUrl + "/member/join-ipinsms?result=yes&type=sms&page="+page; // 성공시 이동될 URL
		String sErrorUrl = baseUrl + "/member/join-ipinsms?result=no&type=sms&page="+page; // 실패시 이동될 URL

		// 입력될 plain 데이타를 만든다.
		String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber + "8:SITECODE"
				+ sSiteCode.getBytes().length + ":" + sSiteCode + "9:AUTH_TYPE" + sAuthType.getBytes().length + ":"
				+ sAuthType + "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl + "7:ERR_URL"
				+ sErrorUrl.getBytes().length + ":" + sErrorUrl + "11:POPUP_GUBUN" + popgubun.getBytes().length + ":"
				+ popgubun + "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + "6:GENDER"
				+ sGender.getBytes().length + ":" + sGender;
		request.getSession().setAttribute("sPlainData", sPlainData);

		String sMessage = "";
		String sEncData = "";

		int sReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
		if (sReturn == 0) {
			sEncData = niceCheck.getCipherData();
			sMessage = "암호화 시스템 성공.";
		} else if (sReturn == -1) {
			sMessage = "암호화 시스템 에러입니다.";
		} else if (sReturn == -2) {
			sMessage = "암호화 처리오류입니다.";
		} else if (sReturn == -3) {
			sMessage = "암호화 데이터 오류입니다.";
		} else if (sReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + sReturn;
		}
		Map<String, Object> sms = new HashMap<String, Object>();
		sms.put("sEncData", sEncData);
		sms.put("sMessage", sMessage);
		return sms;
	}
	
	/** 
	 * @param request
	 * @param commandMap
	 * @return Map<String, Object>
	 */
	public static Map<String,Object> niceIdRes(HttpServletRequest request,CommandMap commandMap){

		Map<String, Object> returnObj = new HashMap<String, Object>();
		boolean is_bool = false;
		NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();

		String sEncodeData = CommonUtils.requestReplace(commandMap.get("EncodeData").toString(), "encodeData");

		String sSiteCode = "G3616"; // NICE로부터 부여받은 사이트 코드
		String sSitePassword = "E6KE7HOCC3UC"; // NICE로부터 부여받은 사이트 패스워드

		String sCipherTime = ""; // 복호화한 시간
		String sRequestNumber = ""; // 요청 번호
		String sResponseNumber = ""; // 인증 고유번호
		String sAuthType = ""; // 인증 수단
		String sName = ""; // 성명
		String sDupInfo = ""; // 중복가입 확인값 (DI_64 byte)
		String sConnInfo = ""; // 연계정보 확인값 (CI_88 byte)
		String sBirthDate = ""; // 생년월일(YYYYMMDD)
		String sGender = ""; // 성별
		String sNationalInfo = ""; // 내/외국인정보 (개발가이드 참조)
		String sMobileNo = ""; // 휴대폰번호
		String sMobileCo = ""; // 통신사
		String sMessage = "";
		String sPlainData = "";

		int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);

		if (iReturn == 0) {
			sPlainData = niceCheck.getPlainData();
			sCipherTime = niceCheck.getCipherDateTime();

			// 데이타를 추출합니다.

			@SuppressWarnings("rawtypes")
			java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

			sRequestNumber = (String) mapresult.get("REQ_SEQ");
			sResponseNumber = (String) mapresult.get("RES_SEQ");
			sAuthType = (String) mapresult.get("AUTH_TYPE");
			sName = (String) mapresult.get("NAME");
			// sName = (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
			sBirthDate = (String) mapresult.get("BIRTHDATE");
			sGender = (String) mapresult.get("GENDER");
			sNationalInfo = (String) mapresult.get("NATIONALINFO");
			sDupInfo = (String) mapresult.get("DI");
			sConnInfo = (String) mapresult.get("CI");
			sMobileNo = (String) mapresult.get("MOBILE_NO");
			sMobileCo = (String) mapresult.get("MOBILE_CO");

			String session_sRequestNumber = (String) request.getSession().getAttribute("sREQ_SEQ");
			is_bool = true;
			if (!sRequestNumber.equals(session_sRequestNumber)) {
				sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
				sResponseNumber = "";
				sAuthType = "";
				is_bool = false;
			} else {
				log.info("세션 정보 : " + session_sRequestNumber + "<BR>");
				log.info("CP 요청번호 : " + sRequestNumber + "<BR>");
				log.info("처리결과 고유번호  : " + sResponseNumber + "<BR>");
				log.info("인증수단 - M : 휴대폰 / C : 신용카드 / X : 공인인증서  : " + sAuthType + "<BR>");
				log.info("DI : " + sDupInfo + "<BR>");
				log.info("CI : " + sConnInfo + "<BR>");
				log.info("이름 : " + sName + "<BR>");
				log.info("성별 코드 - 0:여성 / 1:남성 : " + sGender + "<BR>");
				log.info("생년월일  : " + sBirthDate + "<BR>");
				log.info("휴대폰번호 : " + sMobileNo + "<BR>");
				log.info("통신사정보  : " + sMobileCo + "<BR>");
				sMessage = "정상 처리되었습니다.";
				returnObj.put("DI", sDupInfo);
				returnObj.put("sName", sName);
				returnObj.put("sGender", sGender);
				returnObj.put("sBirthDate", sBirthDate);
				returnObj.put("sMobileNo", sMobileNo);

			}

		} else if (iReturn == -1) {
			sMessage = "복호화 시스템 에러입니다.";
		} else if (iReturn == -4) {
			sMessage = "복호화 처리오류입니다.";
		} else if (iReturn == -5) {
			sMessage = "복호화 해쉬 오류입니다.";
		} else if (iReturn == -6) {
			sMessage = "복호화 데이터 오류입니다.";
		} else if (iReturn == -9) {
			sMessage = "입력 데이터 오류입니다.";
		} else if (iReturn == -12) {
			sMessage = "사이트 패스워드 오류입니다.";
		} else {
			sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
		}
		log.info("MSG:::{},{}", iReturn, sMessage);
		returnObj.put("sMessage", sMessage);


		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap.put("is_bool", is_bool);
		retMap.put("returnObj", returnObj);
		return retMap;
	}
}

class ListMapComparator implements Comparator<Map<String, Object>> {

	private String keyNm;

	public ListMapComparator(String keyNm) {
		this.keyNm = keyNm;
	}

	public int compare(Map<String, Object> map1, Map<String, Object> map2) {
		String value1 = String.valueOf(map1.get(keyNm));
		String value2 = String.valueOf(map2.get(keyNm));
		return value1.compareTo(value2);
	}
}
