package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Popup;
import com.krcon.elif.vo.PopupFile;
 
@Repository("popupDAO")
public class PopupDAO extends AbstractDAO{
	
	
	/** 
	 * @param popupVO
	 * @return List<Popup>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Popup> selectBoardList(Popup popupVO) throws Exception{
	    return (List<Popup>)selectList("popup.selectBoardList", popupVO);
	}

	
	
	/** 
	 * @param popupVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlug(Popup popupVO) throws Exception{
	    return (Integer) selectOne("popup.selectBoardSlug", popupVO);
	}
	
	
	/** 
	 * @param popupVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlugIDX(Popup popupVO) throws Exception{
	    return (Integer) selectOne("popup.selectBoardSlugIDX", popupVO);
	}
	
	/** 
	 * @param popupFileVO
	 * @return List<PopupFile>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PopupFile > selectFileList(PopupFile popupFileVO) throws Exception{
	    return (List<PopupFile>)selectList("popup.selectFileList", popupFileVO);
	}
	
	/** 
	 * @param popupVO
	 * @throws Exception
	 */
	public void insertBoard(Popup popupVO) throws Exception{
	    insert("popup.insertBoard", popupVO);
	}
	
	/** 
	 * @param popupVO
	 * @throws Exception
	 */
	public void updateHitCnt(Popup popupVO) throws Exception{
	    update("popup.updateHitCnt", popupVO);
	}
	 
	
	/** 
	 * @param popupVO
	 * @return Popup
	 * @throws Exception
	 */
	public Popup selectBoardDetail(Popup popupVO) throws Exception{
	    return (Popup) selectOne("popup.selectBoardDetail", popupVO);
	}

	
	/** 
	 * @param popupVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCount(Popup popupVO) throws Exception{
	    return (Integer) selectOne("popup.selectBoardCount", popupVO);
	}
	
	
	/** 
	 * @param popupVO
	 * @throws Exception
	 */
	public void updateBoard(Popup popupVO) throws Exception{
	    update("popup.updateBoard", popupVO);
	}
	
	/** 
	 * @param popupVO
	 * @throws Exception
	 */
	public void deleteBoard(Popup popupVO) throws Exception{
	    update("popup.deleteBoard", popupVO);
	}
	
	/** 
	 * @param popupFileVO
	 * @throws Exception
	 */
	public void insertFile(PopupFile popupFileVO) throws Exception{
	    insert("popup.insertFile", popupFileVO);
	}
	
	/** 
	 * @param popupFileVO
	 * @throws Exception
	 */
	public void deleteFileList(PopupFile popupFileVO) throws Exception{
	    update("popup.deleteFileList", popupFileVO);
	}
	 
	
	/** 
	 * @param popupFileVO
	 * @throws Exception
	 */
	public void updateFile(PopupFile popupFileVO) throws Exception{
	    update("popup.updateFile", popupFileVO);
	}
	
	/** 
	 * @param popupFileVO
	 * @throws Exception
	 */
	public void deleteFile(PopupFile popupFileVO) throws Exception{
	    update("popup.deleteFile", popupFileVO);
	}
}