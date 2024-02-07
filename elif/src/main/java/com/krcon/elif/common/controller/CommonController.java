package com.krcon.elif.common.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.CommandMap;
import com.krcon.elif.common.service.CommonService;


@Configuration
@PropertySource("classpath:system.properties")

@Controller
public class CommonController {
    Logger log = LoggerFactory.getLogger(this.getClass());
    
    
    @Resource(name="commonService")
    private CommonService commonService;
    
	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;
	
    
	/** 
	 * @param commandMap
	 * @param response
	 * @param request
	 * @param httpsession
	 * @throws Exception
	 */
	@RequestMapping(value="/downloadFile")
    public void downloadFile(CommandMap commandMap, HttpServletResponse response, HttpServletRequest request, HttpSession httpsession) throws Exception{
    	if(commandMap.get("BOARD_NAME")==null) {
        	commandMap.put("BOARD_NAME", "BOARD");
    	}
        Map<String,Object> map = commonService.selectFileInfo(commandMap.getMap());
        String storedFileName = (String)map.get("STORED_FILE_NAME");
        String originalFileName = (String)map.get("ORIGINAL_FILE_NAME");
		
        String uploadFolder=(String)map.get("PATH_NAME");
        if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        String fileFolder=httpsession.getServletContext().getRealPath(uploadFolder)+boardSlash;
		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath + uploadFolder+boardSlash;
		}

        byte fileByte[] = FileUtils.readFileToByteArray(new File(fileFolder+storedFileName));
        
        

    	String header = request.getHeader( "User-Agent" );
    	String encodedFilename=originalFileName;
    	if ( header.indexOf( "MSIE" ) > -1 ) {
    		encodedFilename = URLEncoder.encode( originalFileName, "UTF-8" ).replaceAll( "\\+", "%20" );
    	}
    	else if ( header.indexOf( "Trident" ) > -1 ) { 
    		encodedFilename = URLEncoder.encode( originalFileName, "UTF-8" ).replaceAll( "\\+", "%20" );
    	}
    	else if ( header.indexOf( "Chrome" ) > -1 ) {
    		StringBuffer sb = new StringBuffer();
    		for ( int i = 0; i < originalFileName.length(); i++ ) {

    			char c = originalFileName.charAt( i );
    			if ( c > '~' ) {
    				sb.append( URLEncoder.encode( "" + c, "UTF-8" ) );
    			}
    			else {
    				sb.append( c );
    			}
    		}
    		encodedFilename = sb.toString();
    	}else if ( header.indexOf( "Opera" ) > -1 ) {
    		encodedFilename = "\"" + new String( originalFileName.getBytes( "UTF-8" ), "8859_1" ) + "\"";
    	}
    	else if ( header.indexOf( "Safari" ) > -1 ) {
    		encodedFilename = "\"" + new String( originalFileName.getBytes( "UTF-8" ), "8859_1" ) + "\"";
    		encodedFilename = URLDecoder.decode( encodedFilename, "UTF-8" );
    	}else{
    		encodedFilename = "\"" + new String( originalFileName.getBytes( "UTF-8" ), "8859_1" ) + "\"";
    		encodedFilename = URLDecoder.decode( encodedFilename, "UTF-8" );
    	}
    	log.info(encodedFilename);
    	
    	
    	
        
        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; filename=" + encodedFilename + ";" );
        
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);
        
        response.getOutputStream().flush();
        response.getOutputStream().close();
        commonService.updateDownloadCnt(commandMap.getMap());
    }



    
	/** 
	 * @param commandMap
	 * @param response
	 * @param request
	 * @param httpsession
	 * @throws Exception
	 */
	@RequestMapping(value="/download")
    public void download(CommandMap commandMap, HttpServletResponse response,HttpServletRequest request, HttpSession httpsession) throws Exception{
	    	String filename = "";
    		String downloadFile = "";
	    	if(commandMap.get("filename")!=null){
	    		downloadFile = commandMap.get("filename").toString();
	    		filename=httpsession.getServletContext().getRealPath("/resources/file/")+boardSlash+downloadFile;
	    	}else{
	    		downloadFile = commandMap.get("file").toString();
	    		filename=httpsession.getServletContext().getRealPath("/")+downloadFile;
	    	}
	    	
	    	File file = new File(filename);
        byte fileByte[] = FileUtils.readFileToByteArray(file);
        
        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(file.getName(),"UTF-8")+"\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);
        
        response.getOutputStream().flush();
        response.getOutputStream().close();
    }
    @Resource(name="fileUtils")
    private com.krcon.elif.common.util.FileUtils fileUtils;
    
    
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/editorUpload")
    public ModelAndView editorUpload(CommandMap commandMap, HttpServletRequest request) throws Exception{

	    ModelAndView mv = new ModelAndView("redirect:/resource/assets/editor/photo_uploader/popup/file_uploader.jsp");

	    List<Map<String,Object>> list = fileUtils.parseInsertFile(request,"/upload/editor","");
	    
	    for(int i=0, size=list.size(); i<size; i++){
	        mv.addObject("filename", list.get(i).get("STORED_FILE_NAME"));
	    }
	    mv.addObject("byid",commandMap.get("byid"));
	    return mv;
    }

    
	/** 
	 * @param commandMap
	 * @param request
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value="/uploadSummernoteImageFile")
    public ModelAndView uploadSummernoteImageFile(CommandMap commandMap, HttpServletRequest request) throws Exception {

	    ModelAndView mv = new ModelAndView();

		if(!CommonUtils.checkFileExtension(request)) {
	        mv.addObject("responseCode", "error");
		    mv.setViewName("jsonView");
		    return mv;
		}
	    List<Map<String,Object>> list = fileUtils.parseInsertFile(request,"/upload/editor","");
	    
	    for(int i=0, size=list.size(); i<size; i++){
	        mv.addObject("url", "/upload/editor/"+list.get(i).get("STORED_FILE_NAME"));
	    }
        mv.addObject("responseCode", "success");
	    mv.setViewName("jsonView");
	    return mv;
    }
}