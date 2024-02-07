package com.krcon.elif.common.util;


import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Configuration
@PropertySource("classpath:system.properties")

@Component("fileUtils")
public class FileUtils {     

	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;
    
    Logger log = LoggerFactory.getLogger(this.getClass());
    
    /** 
     * @param Map<String
     * @param map
     * @param request
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String,Object>> parseInsertFileInfo(Map<String,Object> map, HttpServletRequest request) throws Exception{
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
        HttpSession httpSession = (HttpSession) request.getSession();
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        String boardIdx = String.valueOf(map.get("IDX"));
        String uploadFolder=String.valueOf(map.get("CATESLUG"))+boardSlash;
        String fileFolder=httpSession.getServletContext().getRealPath(boardPath)+uploadFolder;
		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath+boardPath+ uploadFolder;
		}
        
        File file = new File(fileFolder);
        if(file.exists() == false){
            file.mkdirs();
        }

        int fileSort = 0;
        String fileOldInput = "";
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                 
                file = new File(fileFolder+storedFileName);
                
				listMap = new HashMap<String,Object>();
					String fileSection = multipartFile.getName().split("_")[0];
				if(fileSection.equals(fileOldInput)){
					fileSort++;
				}else{
					fileOldInput = fileSection;
					fileSort = 1;
				}
                multipartFile.transferTo(file);
                listMap.put("BOARD_IDX", boardIdx);
                listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                listMap.put("FILE_GUBUN", fileSection);
                listMap.put("FILE_SORT", fileSort);
                listMap.put("PATH_NAME", boardPath+uploadFolder);
                list.add(listMap);
            }
        }
        return list;
    }
    
    
    /** 
     * @param Map<String
     * @param map
     * @param request
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String, Object>> parseUpdateFileInfo(Map<String, Object> map, HttpServletRequest request) throws Exception{
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
        HttpSession httpSession = (HttpSession) request.getSession();
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        String boardIdx = String.valueOf(map.get("IDX"));
        String requestName = null;
        String idx = null;

        String uploadFolder=String.valueOf(map.get("CATESLUG"))+boardSlash;
        String fileFolder=httpSession.getServletContext().getRealPath(boardPath)+uploadFolder;
		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath+boardPath+ uploadFolder;
		}
        
        File file = new File(fileFolder);
        if(file.exists() == false){
            file.mkdirs();
        }


        int fileSort = 0;
        String fileOldInput = "";
        while(iterator.hasNext()){
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			String fileSection = multipartFile.getName().split("_")[0];
			if(fileSection.equals(fileOldInput)){
				fileSort++;
			}else{
				fileOldInput = fileSection;
				fileSort = 1;
			}
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                
                multipartFile.transferTo(new File(fileFolder+storedFileName));

                listMap = new HashMap<String,Object>();
                requestName = multipartFile.getName();
                idx = fileSection+"idx_"+requestName.substring(requestName.indexOf("_")+1);
                if(map.get(idx)!=null) {
                		listMap.put("IS_NEW", "N");
                		listMap.put("FILE_IDX", map.get(idx));
                }else {
                		listMap.put("IS_NEW", "Y");
                }
                
                listMap.put("BOARD_IDX", boardIdx);
                listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                listMap.put("FILE_GUBUN", fileSection);
                listMap.put("FILE_SORT", fileSort);
                listMap.put("PATH_NAME", boardPath+uploadFolder);
                list.add(listMap);
            }/*else{
                requestName = multipartFile.getName();
                idx = fileSection+"idx_"+requestName.substring(requestName.indexOf("_")+1);
                if(map.containsKey(idx) == true && map.get(idx) != null){
                    listMap = new HashMap<String,Object>();
                    listMap.put("IS_NEW", "N");
                    listMap.put("FILE_IDX", map.get(idx));
                    list.add(listMap);
                }
            }*/
        }
        return list;
    }
    

    
    /** 
     * @param request
     * @param filepath
     * @param inputname
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    public List<Map<String,Object>> parseInsertFile(HttpServletRequest request,String filepath,String inputname) throws Exception{
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
        HttpSession httpSession = (HttpSession) request.getSession();
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        Map<String, Object> listMap = null; 
        
        String uploadFolder=filepath+boardSlash;
        String fileFolder=httpSession.getServletContext().getRealPath(boardSlash)+uploadFolder;
		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath;
			fileFolder = fileFolder + uploadFolder;
		}		
        File file = new File(fileFolder);
        if(file.exists() == false){
            file.mkdirs();
        }

        while(iterator.hasNext()){
            String strFile = iterator.next();
            if(strFile.indexOf(inputname)==0){
                multipartFile = multipartHttpServletRequest.getFile(strFile);
                if(multipartFile.isEmpty() == false){
                    originalFileName = multipartFile.getOriginalFilename();
                    originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                    storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                     
                    file = new File(fileFolder+storedFileName);
                    multipartFile.transferTo(file);
                     
                    listMap = new HashMap<String,Object>();
                    listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                    listMap.put("STORED_FILE_NAME", storedFileName);
                    listMap.put("FILE_SIZE", multipartFile.getSize());
                    list.add(listMap);
                }
            }
        }
        return list;
    }
    
    
    /** 
     * @param request
     * @param filepath
     * @param inputname
     * @return Map<String, Object>
     * @throws Exception
     */
    public Map<String,Object> parseUploadFile(HttpServletRequest request, String filepath, String inputname) throws Exception{
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        HttpSession httpSession = (HttpSession) request.getSession();
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;
         
        Map<String, Object> listMap = new HashMap<String,Object>();
        

        String uploadFolder=boardPath+"/"+filepath+"/";
        String fileFolder=httpSession.getServletContext().getRealPath(boardSlash)+uploadFolder;

		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath;
			fileFolder = fileFolder + uploadFolder;
		}		
        File file = new File(fileFolder);
        if(file.exists() == false){
            file.mkdirs();
        }


        multipartFile = multipartHttpServletRequest.getFile(inputname);
        if(multipartFile!=null) {
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                 
                file = new File(fileFolder+storedFileName);
                multipartFile.transferTo(file);
                listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
            }
        }
        return listMap;
    }

    
    /** 
     * @param request
     * @param filepath
     * @param inputname
     * @return String
     * @throws Exception
     */
    public String parseItemFile(HttpServletRequest request, String filepath, String inputname) throws Exception{

        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;

    	if(request.getServerName().equals("krcon-elif.dal.so")) {
    		uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("52.79.178.53")>-1) {
    		uploadPath = "/data/app/elif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}

        String uploadFolder=boardPath+"/"+filepath+"/";
        HttpSession httpSession = (HttpSession) request.getSession();
        String fileFolder=httpSession.getServletContext().getRealPath(boardSlash)+uploadFolder;
        
		File f = new File(uploadPath);
		if (f.exists() && f.isDirectory()) {
			fileFolder=uploadPath;
			fileFolder = fileFolder + uploadFolder;
		}		
        File file = new File(fileFolder);
        if(file.exists() == false){
            file.mkdirs();
        }
        
        multipartFile = multipartHttpServletRequest.getFile(inputname);
        if(multipartFile!=null) {
            if(multipartFile.isEmpty() == false){
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                
                file = new File(fileFolder+storedFileName);
                multipartFile.transferTo(file);
                
            }
        }
        return storedFileName;
    }
    

    
    /** 
     * @param request
     * @param filepath
     * @param inputname
     * @return boolean
     * @throws Exception
     */
    public boolean deleteFile(HttpServletRequest request, String filepath, String inputname) throws Exception{
        HttpSession httpSession = (HttpSession) request.getSession();
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
			uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
		log.info("uploadFolder:: {}",filepath);
        String fileFolder=httpSession.getServletContext().getRealPath(boardSlash)+filepath;

		log.info("fileFolder:: {}",fileFolder);
		boolean returnBool = false;
		String realFile = fileFolder+inputname;
		log.info("realFile:: {}",realFile);
        File file = new File(realFile);
        if(file.exists()){
        	if(file.delete()){ 
        		System.out.println("파일삭제 성공"); 
        		returnBool = true;
        	}else{ 
        		System.out.println("파일삭제 실패"); 
        	}
        }else {
        	System.out.println("파일 없음");
        }
        return returnBool;
    }
    
    /** 
     * @param request
     * @param realFile
     * @return boolean
     * @throws Exception
     */
    public boolean deleteRealFile(HttpServletRequest request, String realFile) throws Exception{
        HttpSession httpSession = (HttpSession) request.getSession();
    	if(request.getServerName().equals("krcon-elif.dal.so")) {
			uploadPath = "/storage/local/apache-tomcat-9.0.40/node-files/krconelif";
    	}else if(request.getServerName().indexOf("testelif.krcon.co.kr")>-1) {
    		uploadPath = "/efs/web";
    	}
        String fileFolder=httpSession.getServletContext().getRealPath(boardSlash)+realFile;

		boolean returnBool = false;
		log.info("realFile:: {}",fileFolder);
        File file = new File(fileFolder);
        if(file.exists()){
        	if(file.delete()){ 
        		System.out.println("파일삭제 성공"); 
        		returnBool = true;
        	}else{ 
        		System.out.println("파일삭제 실패"); 
        	}
        }else {
        	System.out.println("파일 없음");
        }
        return returnBool;
    }
}