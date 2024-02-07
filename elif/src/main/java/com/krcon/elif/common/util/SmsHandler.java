package com.krcon.elif.common.util;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.util.Map;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication(scanBasePackages = {"com.krcon.elif.common.util"})
public class SmsHandler {
	@Value("${sys.send_username}")
	private String send_username;
	@Value("${sys.send_key}")
	private String send_key;
	@Value("${sys.send_sender}")
	private String sms_sender;

	protected Logger log = LoggerFactory.getLogger(SmsHandler.class);

	
	/** 
	 * @param to
	 * @param title
	 * @param message
	 * @param pass
	 * @return boolean
	 * @throws IOException
	 */
	public boolean directSendSms(String to, String title, String message, String pass) throws IOException{

		String receiver = "{\"name\": \"고객님\", \"mobile\":\""+to+"\",\"note1\":\""+pass+"\"}";
		receiver = "["+ receiver +"]";

		String urlParameters = "\"title\":\"" + title + "\" "
			+ ", \"message\":\"" + message + "\" "
			+ ", \"sender\":\"" + sms_sender + "\" "
			+ ", \"username\":\"" + send_username + "\" "
			+ ", \"receiver\":" + receiver 
			//+ ", \"address_books\":\"" + address_books + "\" " 

			// 예약 관련 파라미터 주석 해제
			//+ ", \"sms_type\":\"" + sms_type + "\" "
			//+ ", \"start_reserve_time\":\"" + start_reserve_time + "\" "
			//+ ", \"end_reserve_time\":\"" + end_reserve_time + "\" "
			//+ ", \"remained_count\":\"" + remained_count + "\" "

			//+ ", \"return_url_yn\": " + true		//returnURL이 있는 경우 주석해제 바랍니다.(필수입력)
			//+ ", \"return_url\":\"" + returnURL  + "\" " // returnURL이 있는 경우 주석해제 바랍니다.
			+ ", \"key\":\"" + send_key + "\" " 
			+ ", \"type\":\"" + "java" + "\" ";
			//+ ", \"attaches\":\"" + attaches + "\" ";	// 첨부파일이 있는 경우 주석해제 바랍니다.
		urlParameters = "{"+ urlParameters  +"}";		//JSON 데이터

		String url = "https://directsend.co.kr/index.php/api_v2/sms_change_word";		// URL

		if(directSendReturn(url,urlParameters,"SMS")>=100){
			return false;
		}else{
			return true;
		}
	}
	
	/** 
	 * @param url
	 * @param postvars
	 * @param type
	 * @return int
	 * @throws IOException
	 */
	public int directSendReturn(String url, String postvars,String type) throws IOException{
		int retVal=1;
		java.net.URL obj;
		obj = new java.net.URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestProperty("Cache-Control", "no-cache");
		con.setRequestProperty("Content-Type", "application/json;charset=utf-8");
		con.setRequestProperty("Accept", "application/json");

		System.setProperty("jsse.enableSNIExtension", "false");
		con.setDoOutput(true);
		OutputStreamWriter  wr = new OutputStreamWriter (con.getOutputStream());
		wr.write(postvars);
		wr.flush();
		wr.close();

		int responseCode = con.getResponseCode();
		System.out.println(responseCode);

		/*
		* responseCode 가 200 이 아니면 내부에서 문제가 발생한 케이스입니다.
		* directsend 관리자에게 문의해주시기 바랍니다.
		*/

		java.io.BufferedReader in = new java.io.BufferedReader(
			new java.io.InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();

		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}

		in.close();

		System.out.println(response.toString());
		
		// STATUS CODE 값이 0(정상발송)이 아닌 경우, return false
		try {
			ScriptEngineManager sem = new ScriptEngineManager();
	        ScriptEngine engine = sem.getEngineByName("javascript");
			String script = "Java.asJSONCompatible(" + response.toString() + ")";
	        // Object result;
			// result = engine.eval(script);
			@SuppressWarnings("rawtypes")
	        Map contents = (Map)engine.eval(script);
	        log.info( " [ "+ type +" DIRECT SEND API : STATUS CODE ] " + contents.get("status"));
	        
	        retVal=Integer.parseInt((String) contents.get("status"));
	        
		} catch (ScriptException e) {
			retVal=999;
		}
		return retVal;
	}
}
