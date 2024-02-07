package com.krcon.elif.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.krcon.elif.dao.BoardDAO;
import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.FileUtils;

import com.krcon.elif.vo.BoardCate;
import com.krcon.elif.vo.BoardCateCode;
import com.krcon.elif.vo.Board;
import com.krcon.elif.vo.BoardFile;
import com.krcon.elif.vo.BoardDownload;

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.upload.path}")
    private String uploadPath;
	
	@Value("${sys.upload.boardpath}")
    private String boardPath;

	@Value("${sys.upload.boardslash}")
    private String boardSlash;

    @Resource(name="fileUtils")
    private FileUtils fileUtils;
     
    @Resource(name="boardDAO")
    private BoardDAO boardDAO;

	@Value("${sys.inquiry.delete}")
    private String delPiriod;
	
    
    
	/** 
	 * @param boardCateVO
	 * @return List<BoardCate>
	 * @throws Exception
	 */
	public List<BoardCate> selectBoardCategory(BoardCate boardCateVO) throws Exception {
        return (List<BoardCate>) boardDAO.selectBoardCategory(boardCateVO);
    }
	
    
	/** 
	 * @param boardCateVO
	 * @return List<BoardCate>
	 * @throws Exception
	 */
	public List<BoardCate> selectBoardShortCategory(BoardCate boardCateVO) throws Exception {
        return (List<BoardCate>) boardDAO.selectBoardShortCategory(boardCateVO);
    }
	
	
	/** 
	 * @param str
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCategorySlug(String str) throws Exception {
	    return boardDAO.selectBoardCategorySlug(str);
	}
	
	
	/** 
	 * @param str
	 * @return String
	 * @throws Exception
	 */
	public String selectBoardCategoryIpSlug(Integer str) throws Exception {
	    return boardDAO.selectBoardCategoryIpSlug(str);
	}
	
	
	/** 
	 * @param boardCateVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCateCntSlug(BoardCate boardCateVO) throws Exception {
	    return boardDAO.selectBoardCateCntSlug(boardCateVO);
	}
	
	
	/** 
	 * @param boardCateVO
	 * @return BoardCate
	 * @throws Exception
	 */
	public BoardCate selectBoardCategoryDetail(BoardCate boardCateVO) throws Exception {
	    return (BoardCate) boardDAO.selectBoardCategoryDetail(boardCateVO);
	}
	
	
	
	/** 
	 * @param boardCateVO
	 * @param request
	 * @throws Exception
	 */
	public void insertCategory(BoardCate boardCateVO, HttpServletRequest request) throws Exception {
	    boardDAO.insertCategory(boardCateVO);
	}
	
	
	/** 
	 * @param boardCateVO
	 * @param request
	 * @throws Exception
	 */
	public void updateCategory(BoardCate boardCateVO, HttpServletRequest request) throws Exception{
	    boardDAO.updateCategory(boardCateVO);
	}
	
	
	
	/** 
	 * @param boardCateVO
	 * @throws Exception
	 */
	public void deleteCategory(BoardCate boardCateVO) throws Exception {
	    boardDAO.deleteCategory(boardCateVO);
	}
	
	
    
	/** 
	 * @param boardCateCodeVO
	 * @return List<BoardCateCode>
	 * @throws Exception
	 */
	public List<BoardCateCode> selectBoardCateCode(BoardCateCode boardCateCodeVO) throws Exception {
        return (List<BoardCateCode>) boardDAO.selectBoardCateCode(boardCateCodeVO);
    }
	
	
	/** 
	 * @param boardCateCodeVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCateCodeCnt(BoardCateCode boardCateCodeVO) throws Exception {
	    return boardDAO.selectBoardCateCodeCnt(boardCateCodeVO);
	}
	
	
	/** 
	 * @param boardCateCodeVO
	 * @param request
	 * @throws Exception
	 */
	public void insertCateCode(BoardCateCode boardCateCodeVO, HttpServletRequest request) throws Exception {
	    boardDAO.insertCateCode(boardCateCodeVO);
	}
	
	
	/** 
	 * @param boardCateCodeVO
	 * @param request
	 * @throws Exception
	 */
	public void updateCateCode(BoardCateCode boardCateCodeVO, HttpServletRequest request) throws Exception{
	    boardDAO.updateCateCode(boardCateCodeVO);
	}
	
	
	
	/** 
	 * @param boardCateCodeVO
	 * @throws Exception
	 */
	public void deleteCateCode(BoardCateCode boardCateCodeVO) throws Exception {
	    boardDAO.deleteCateCode(boardCateCodeVO);
	}
	
    
    
	/** 
	 * @param boardVO
	 * @return List<Board>
	 * @throws Exception
	 */
	public List<Board> selectBoardList(Board boardVO) throws Exception {
        return (List<Board>) boardDAO.selectBoardList(boardVO);
    }
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlug(Board boardVO) throws Exception {
	    return boardDAO.selectBoardSlug(boardVO);
	}
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlugIDX(Board boardVO) throws Exception {
	    return boardDAO.selectBoardSlugIDX(boardVO);
	}
	
    
    
	/** 
	 * @param boardFileVO
	 * @return List<BoardFile>
	 * @throws Exception
	 */
	public List<BoardFile> selectFileList(BoardFile boardFileVO) throws Exception {
        return boardDAO.selectFileList(boardFileVO);
    }
    
	
	
	/** 
	 * @param boardVO
	 * @param request
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void insertBoard(Board boardVO, HttpServletRequest request) throws Exception {
	    boardDAO.insertBoard(boardVO);
	    
	    List<BoardFile> boardFileList = parseInsertFileInfo(boardVO, request);
        for (BoardFile boardFileForm : boardFileList) {
        	boardDAO.insertFile(boardFileForm);
        }
	}
	
	
	
	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	public Board selectBoardDetail(Board boardVO) throws Exception {
	    return boardDAO.selectBoardDetail(boardVO);
	}
	
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCount(Board boardVO) throws Exception {
	    return boardDAO.selectBoardCount(boardVO);
	}
	
	
	
	/** 
	 * @param boardVO
	 * @param request
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void updateBoard(Board boardVO, HttpServletRequest request) throws Exception{
	    boardDAO.updateBoard(boardVO);
	    
	    BoardFile boardFileVO = new BoardFile();
	    boardFileVO.setBoard_idx(boardVO.getIdx());
	    //boardDAO.deleteFileList(boardFileVO);

	    List<BoardFile> boardFileList = parseInsertFileInfo(boardVO, request);
        for (BoardFile boardFileForm : boardFileList) {
        	if(boardFileForm.getIs_new().equals("Y")) {
        		boardDAO.insertFile(boardFileForm);
        	}else {
        		boardDAO.updateFile(boardFileForm);
        	}
        	
        }
        
	}
	
	
	
	/** 
	 * @param boardVO
	 * @param request
	 * @throws Exception
	 */
	public void deleteBoard(Board boardVO, HttpServletRequest request) throws Exception {
		
	    boardDAO.deleteBoard(boardVO);
	    BoardFile boardFileVO = new BoardFile();
	    boardFileVO.setBoard_idx(boardVO.getIdx());
	    boardDAO.deleteFileList(boardFileVO);
		List<BoardFile> boardFileList = boardDAO.selectFileList(boardFileVO);

        for (BoardFile boardFileForm : boardFileList) {
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
	 * @param boardVO
	 * @return List<String>
	 * @throws Exception
	 */
	public List<String> selectBoardGroupGubun(Board boardVO) throws Exception {
        return boardDAO.selectBoardGroupGubun(boardVO);
    }
    
	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	@Override
	public Board selectBoardDetailPrev(Board boardVO) throws Exception {
		return boardDAO.selectBoardDetailPrev(boardVO);
	}

	
	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	@Override
	public Board selectBoardDetailNext(Board boardVO) throws Exception {
		return boardDAO.selectBoardDetailNext(boardVO);
	}

	
	
	/** 
	 * @param boardVO
	 * @param request
	 * @throws Exception
	 */
	public void deleteFile(BoardFile boardVO, HttpServletRequest request) throws Exception {
		BoardFile boardFileForm = boardDAO.selectFileDetail(boardVO);
    	if(boardDAO.deleteFile(boardVO)>0) {
    		try {
    			fileUtils.deleteFile(request, boardFileForm.getPath_name(), boardFileForm.getStored_file_name());
    		} catch (Exception e) {
    			e.printStackTrace();
    		}
    		
    	}
	}

	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateHitCnt(Board boardVO) throws Exception{
		return (int)boardDAO.updateHitCnt(boardVO);
	}
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateStatus(Board boardVO) throws Exception{
		return (int)boardDAO.updateStatus(boardVO);
	}
	
	
	
	
	
	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int selectDownloadCount(BoardDownload boardDownloadVO) throws Exception {
	    return boardDAO.selectDownloadCount(boardDownloadVO);
	}
    
    
	/** 
	 * @param boardDownloadVO
	 * @return List<BoardDownload>
	 * @throws Exception
	 */
	public List<BoardDownload> selectDownloadList(BoardDownload boardDownloadVO) throws Exception {
        return (List<BoardDownload>) boardDAO.selectDownloadList(boardDownloadVO);
    }
	
	
	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int selectDownloadDeleteCount(BoardDownload boardDownloadVO) throws Exception {
	    return boardDAO.selectDownloadDeleteCount(boardDownloadVO);
	}
    
    
	/** 
	 * @param boardDownloadVO
	 * @return List<BoardDownload>
	 * @throws Exception
	 */
	public List<BoardDownload> selectDownloadDeleteList(BoardDownload boardDownloadVO) throws Exception {
		boardDownloadVO.setDel_piriod(delPiriod);
        return (List<BoardDownload>) boardDAO.selectDownloadDeleteList(boardDownloadVO);
    }
	
	
	
	/** 
	 * @param boardDownloadVO
	 * @throws Exception
	 */
	public void deleteDownloadAll(BoardDownload boardDownloadVO) throws Exception {
		boardDownloadVO.setDel_piriod(delPiriod);
	    boardDAO.deleteDownloadAll(boardDownloadVO);
	}
	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int insertDownload(BoardDownload boardDownloadVO) throws Exception {
		return boardDAO.insertDownload(boardDownloadVO);
	}
    
	
	





    
	/** 
	 * @param boardVO
	 * @param request
	 * @return List<BoardFile>
	 * @throws Exception
	 */
	public List<BoardFile> parseInsertFileInfo(Board boardVO, HttpServletRequest request) throws Exception{
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
         
        List<BoardFile> boardFileList = new ArrayList<BoardFile>();
        
        String uploadFolder=String.valueOf(boardVO.getCateslug())+boardSlash;
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
				BoardFile boardFileForm = new BoardFile();
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
                log.info(paraIdx);
                if(request.getParameter(paraIdx)!=null) {
            		boardFileForm.setIs_new("N");
            		boardFileForm.setIdx(Integer.parseInt(request.getParameter(paraIdx)));
                }else {
                	boardFileForm.setIs_new("Y");
                }
                boardFileForm.setBoard_idx(boardVO.getIdx());
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