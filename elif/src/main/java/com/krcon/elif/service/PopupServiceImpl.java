package com.krcon.elif.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.FileUtils;
import com.krcon.elif.dao.PopupDAO;
import com.krcon.elif.vo.Popup;
import com.krcon.elif.vo.PopupFile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Service("popupService")
public class PopupServiceImpl implements PopupService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.upload.path}")
    private String uploadPath;

	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;
    
    @Resource(name="fileUtils")
    private FileUtils fileUtils;
     
    @Resource(name="popupDAO")
    private PopupDAO popupDAO;

    
	/** 
	 * @param popupVO
	 * @return List<Popup>
	 * @throws Exception
	 */
	@Override
    public List<Popup> selectBoardList(Popup popupVO) throws Exception {
        return popupDAO.selectBoardList(popupVO);
    }

	
	/** 
	 * @param popupVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCount(Popup popupVO) throws Exception {
	    return popupDAO.selectBoardCount(popupVO);
	}
	
    
	/** 
	 * @param popupFileVO
	 * @return List<PopupFile>
	 * @throws Exception
	 */
	@Override
    public List<PopupFile> selectFileList(PopupFile popupFileVO) throws Exception {
        return popupDAO.selectFileList(popupFileVO);
    }
    
	
	/** 
	 * @param popupVO
	 * @param request
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void insertBoard(Popup popupVO, HttpServletRequest request) throws Exception {
	    popupDAO.insertBoard(popupVO);
	    
	    List<PopupFile> boardFileList = parseInsertFileInfo(popupVO, request);
        for (PopupFile boardFileForm : boardFileList) {
        	popupDAO.insertFile(boardFileForm);
        }
	}
	
	
	/** 
	 * @param popupVO
	 * @return Popup
	 * @throws Exception
	 */
	@Override
	public Popup selectBoardDetail(Popup popupVO) throws Exception {
	    return popupDAO.selectBoardDetail(popupVO);
	}
	
	
	/** 
	 * @param popupVO
	 * @param request
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void updateBoard(Popup popupVO, HttpServletRequest request) throws Exception{
	    popupDAO.updateBoard(popupVO);
	    
	    PopupFile boardFileVO = new PopupFile();
	    boardFileVO.setBoard_idx(popupVO.getIdx());
	    //boardDAO.deleteFileList(boardFileVO);

	    List<PopupFile> boardFileList = parseInsertFileInfo(popupVO, request);
        for (PopupFile boardFileForm : boardFileList) {
        	if(boardFileForm.getIs_new().equals("Y")) {
        		popupDAO.insertFile(boardFileForm);
        	}else {
        		popupDAO.updateFile(boardFileForm);
        	}
        	
        }
	}
	
	
	/** 
	 * @param popupVO
	 * @param request
	 * @throws Exception
	 */
	@Override
	public void deleteBoard(Popup popupVO, HttpServletRequest request) throws Exception {
	    popupDAO.deleteBoard(popupVO);
	    PopupFile popupFileVO = new PopupFile();
	    popupFileVO.setBoard_idx(popupVO.getIdx());
	    popupDAO.deleteFileList(popupFileVO);

		List<PopupFile> boardFileList = popupDAO.selectFileList(popupFileVO);

        for (PopupFile boardFileForm : boardFileList) {
        	if(boardFileForm.getPath_name()!=null) {
				try {
					fileUtils.deleteFile(request, boardFileForm.getPath_name(), boardFileForm.getStored_file_name());
				} catch (Exception e) {
					e.printStackTrace();
				}
        		
        	}
        }
	}
	
	/** 
	 * @param popupFileVO
	 * @throws Exception
	 */
	@Override
	public void deleteFile(PopupFile popupFileVO) throws Exception {
    	popupDAO.deleteFile(popupFileVO);
	}

	
	/** 
	 * @param popupVO
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void updateHitCnt(Popup popupVO) throws Exception{
		popupDAO.updateHitCnt(popupVO);
	}

    
	/** 
	 * @param popupVO
	 * @param request
	 * @return List<PopupFile>
	 * @throws Exception
	 */
	public List<PopupFile> parseInsertFileInfo(Popup popupVO, HttpServletRequest request) throws Exception{
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
         
        List<PopupFile> boardFileList = new ArrayList<PopupFile>();
        
        
        String uploadFolder="popup"+boardSlash;
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
				PopupFile boardFileForm = new PopupFile();
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                 
                file = new File(fileFolder+storedFileName);
				String fileSection = multipartFile.getName().split("_")[0];
				if(fileSection.equals(fileOldInput)){
					fileSort++;
				}else{
					fileOldInput = fileSection;
					fileSort = 1;
				}
                multipartFile.transferTo(file);
                String requestName = multipartFile.getName();
                String paraIdx = fileSection+"idx_"+requestName.substring(requestName.indexOf("_")+1);
                if(request.getParameter(paraIdx)!=null) {
            		boardFileForm.setIs_new("N");
            		boardFileForm.setIdx(Integer.parseInt(request.getParameter(paraIdx)));
                }else {
                	boardFileForm.setIs_new("Y");
                }
                boardFileForm.setBoard_idx(popupVO.getIdx());
                boardFileForm.setOriginal_file_name(originalFileName);
                boardFileForm.setStored_file_name(storedFileName);
                boardFileForm.setFile_gubun(fileSection);
                boardFileForm.setFile_size(multipartFile.getSize());
                boardFileForm.setFile_sort(fileSort);
                boardFileForm.setPath_name(boardPath+uploadFolder);
                boardFileList.add(boardFileForm);
            }
        }
        return boardFileList;
    }
    
	
}	