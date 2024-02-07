package com.krcon.elif.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import com.krcon.elif.common.CommonTld;

// import org.slf4j.Logger;
// import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;


public class MailHandler {
	private JavaMailSender mailSender;
	private MimeMessage message;
	private MimeMessageHelper messageHelper;

	
	// protected static Logger log = LoggerFactory.getLogger(MailHandler.class);
	
	public MailHandler(JavaMailSender mailSender) throws MessagingException {
		this.mailSender = mailSender;
		message = this.mailSender.createMimeMessage();
		messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	}

	
	/** 
	 * @param subject
	 * @throws MessagingException
	 */
	public void setSubject(String subject) throws MessagingException {
		messageHelper.setSubject(subject);
	}

	
	/** 
	 * @param htmlContent
	 * @throws MessagingException
	 */
	public void setText(String htmlContent) throws MessagingException {
		messageHelper.setText(htmlContent, true);
	}

	
	/** 
	 * @param email
	 * @param name
	 * @throws UnsupportedEncodingException
	 * @throws MessagingException
	 */
	public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
		messageHelper.setFrom(email, name);
	}

	
	/** 
	 * @param email
	 * @throws MessagingException
	 */
	public void setTo(String email) throws MessagingException {
		messageHelper.setTo(email);
	}

	
	/** 
	 * @param contentId
	 * @param dataSource
	 * @throws MessagingException
	 */
	public void addInline(String contentId, DataSource dataSource) throws MessagingException {
		messageHelper.addInline(contentId, dataSource);
	}

	public void send() {
        try {
        	mailSender.send(message);
        }catch(Exception e) {
            e.printStackTrace();
        }
	}

	
	/** 
	 * @param map
	 * @param filename
	 * @return String
	 * @throws Exception
	 */
	public static String mailMapReplace(HashMap<String,Object> map,String filename) throws Exception{
		StringBuffer sb = new StringBuffer();
		Resource resource = new ClassPathResource("/static/mail/"+filename+".html");
		File file = resource.getFile();
		try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"))) {
			String line="";
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		String sbStr = sb.toString();
		for( Entry<String, Object> elem : map.entrySet() ){
			String value = "";
			if(elem.getValue()!=null){
				value = elem.getValue().toString();
				value = CommonUtils.nl2br(value);
			}
			if(elem.getKey().equals("name")){
				value = CommonTld.getMaskedName(value);
			}
			if(elem.getKey().equals("email")){
				value = CommonTld.getMaskedEmail(value);
			}
			if(elem.getKey().equals("tel")){
				value = CommonTld.getMaskedPhoneNum(value);
			}
			sbStr = sbStr.replace("[_"+elem.getKey()+"_]",value);
			
        }
	    return sbStr;
	}
    
	/** 
	 * @param sender
	 * @param from
	 * @param to
	 * @param subject
	 * @param filename
	 * @param map
	 * @return boolean
	 * @throws IOException
	 */
	public static boolean getMailSend(JavaMailSender sender,String from,String to,String subject,String filename,HashMap<String,Object> map) throws IOException {
    	
		String mailContent="";
		try {
			mailContent = mailMapReplace(map,filename);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			MimeMessage message = sender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(mailContent,true);
			sender.send(message);
			return true;
	    }
	    catch(Exception e){
	        e.printStackTrace();
			return false;
	    }
    }
}
