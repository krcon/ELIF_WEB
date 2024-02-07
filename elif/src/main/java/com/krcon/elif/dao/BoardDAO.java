package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.krcon.elif.common.dao.AbstractDAO;

import com.krcon.elif.vo.BoardCate;
import com.krcon.elif.vo.BoardCateCode;
import com.krcon.elif.vo.Board;
import com.krcon.elif.vo.BoardFile;
import com.krcon.elif.vo.BoardDownload;

@Repository("boardDAO")
public class BoardDAO extends AbstractDAO{
	
	/** 
	 * @param boardCateVO
	 * @return List<BoardCate>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardCate> selectBoardCategory(BoardCate boardCateVO) throws Exception{
	    return (List<BoardCate>)selectList("board.selectBoardCategory", boardCateVO);
	}
	
	/** 
	 * @param boardCateVO
	 * @return List<BoardCate>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardCate> selectBoardShortCategory(BoardCate boardCateVO) throws Exception{
	    return (List<BoardCate>)selectList("board.selectBoardShortCategory", boardCateVO);
	}
	
	/** 
	 * @param str
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCategorySlug(String str) throws Exception{
	    return (Integer) selectOne("board.selectBoardCategorySlug", str);
	}
	
	/** 
	 * @param str
	 * @return String
	 * @throws Exception
	 */
	public String selectBoardCategoryIpSlug(Integer str) throws Exception{
	    return (String) selectOne("board.selectBoardCategoryIpSlug", str);
	}
	
	/** 
	 * @param boardCateVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCateCntSlug(BoardCate boardCateVO) throws Exception{
	    return (Integer) selectOne("board.selectBoardCateCntSlug", boardCateVO);
	}
	
	/** 
	 * @param boardCateVO
	 * @return BoardCate
	 * @throws Exception
	 */
	public BoardCate selectBoardCategoryDetail(BoardCate boardCateVO) throws Exception{
	    return (BoardCate) selectOne("board.selectBoardCategoryDetail", boardCateVO);
	}
	
	/** 
	 * @param boardCateVO
	 * @throws Exception
	 */
	public void insertCategory(BoardCate boardCateVO) throws Exception{
	    insert("board.insertCategory", boardCateVO);
	}
	
	/** 
	 * @param boardCateVO
	 * @throws Exception
	 */
	public void updateCategory(BoardCate boardCateVO) throws Exception{
	    update("board.updateCategory", boardCateVO);
	}
	
	/** 
	 * @param boardCateVO
	 * @throws Exception
	 */
	public void deleteCategory(BoardCate boardCateVO) throws Exception{
	    update("board.deleteCategory", boardCateVO);
	}
	
	
	
	/** 
	 * @param boardCateCodeVO
	 * @return List<BoardCateCode>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardCateCode> selectBoardCateCode(BoardCateCode boardCateCodeVO) throws Exception{
	    return (List<BoardCateCode>)selectList("board.selectBoardCateCode", boardCateCodeVO);
	}
	
	/** 
	 * @param boardCateCodeVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCateCodeCnt(BoardCateCode boardCateCodeVO) throws Exception{
	    return (Integer) selectOne("board.selectBoardCateCodeCnt", boardCateCodeVO);
	}
	
	/** 
	 * @param boardCateCodeVO
	 * @throws Exception
	 */
	public void insertCateCode(BoardCateCode boardCateCodeVO) throws Exception{
	    insert("board.insertCateCode", boardCateCodeVO);
	}
	
	/** 
	 * @param boardCateCodeVO
	 * @throws Exception
	 */
	public void updateCateCode(BoardCateCode boardCateCodeVO) throws Exception{
	    update("board.updateCateCode", boardCateCodeVO);
	}
	
	/** 
	 * @param boardCateCodeVO
	 * @throws Exception
	 */
	public void deleteCateCode(BoardCateCode boardCateCodeVO) throws Exception{
	    update("board.deleteCateCode", boardCateCodeVO);
	}
	
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardCount(Board boardVO) throws Exception{
	    return (Integer) selectOne("board.selectBoardCount", boardVO);
	}
	
	/** 
	 * @param boardVO
	 * @return List<Board>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Board> selectBoardList(Board boardVO) throws Exception{
	    return (List<Board>)selectList("board.selectBoardList", boardVO);
	}
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlug(Board boardVO) throws Exception{
	    return (Integer) selectOne("board.selectBoardSlug", boardVO);
	}
	
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int selectBoardSlugIDX(Board boardVO) throws Exception{
	    return (Integer) selectOne("board.selectBoardSlugIDX", boardVO);
	}
	
	/** 
	 * @param boardFileVO
	 * @return List<BoardFile>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardFile> selectFileList(BoardFile boardFileVO) throws Exception{
	    return (List<BoardFile>)selectList("board.selectFileList", boardFileVO);
	}
	
	/** 
	 * @param boardFileVO
	 * @return BoardFile
	 * @throws Exception
	 */
	public BoardFile selectFileDetail(BoardFile boardFileVO) throws Exception{
	    return (BoardFile) selectOne("board.selectFileDetail", boardFileVO);
	}
	
	/** 
	 * @param boardVO
	 * @throws Exception
	 */
	@Transactional
	public void insertBoard(Board boardVO) throws Exception{
	    insert("board.insertBoard", boardVO);
		// Board lobBoardVO = new Board();
		// lobBoardVO.setIdx(boardVO.getIdx());
		// lobBoardVO.setContents(boardVO.getContents());
		// lobBoardVO.setContents_mobile(boardVO.getContents_mobile());
	    // update("board.updateContentsBoard", boardVO);
	}
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int updateHitCnt(Board boardVO) throws Exception{
	    return (Integer) update("board.updateHitCnt", boardVO);
	}
	 
	
	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	public Board selectBoardDetail(Board boardVO) throws Exception{
	    return (Board) selectOne("board.selectBoardDetail", boardVO);
	}

	
	
	/** 
	 * @param boardVO
	 * @throws Exception
	 */
	public void updateBoard(Board boardVO) throws Exception{
	    update("board.updateBoard", boardVO);
	}
	
	/** 
	 * @param boardVO
	 * @throws Exception
	 */
	public void deleteBoard(Board boardVO) throws Exception{
	    update("board.deleteBoard", boardVO);
	}

	
	/** 
	 * @param boardVO
	 * @return List<String>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> selectBoardGroupGubun(Board boardVO) throws Exception{
	    return (List<String>)selectList("board.selectBoardGroupGubun", boardVO);
	}

	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	public Board selectBoardDetailPrev(Board boardVO) throws Exception {
		return (Board) selectOne("board.selectBoardDetailPrev", boardVO);
	}

	
	/** 
	 * @param boardVO
	 * @return Board
	 * @throws Exception
	 */
	public Board selectBoardDetailNext(Board boardVO) throws Exception {
		return (Board) selectOne("board.selectBoardDetailNext", boardVO);
	}

	
	/** 
	 * @param boardFileVO
	 * @throws Exception
	 */
	public void insertFile(BoardFile boardFileVO) throws Exception{
	    insert("board.insertFile", boardFileVO);
	}
	
	/** 
	 * @param boardFileVO
	 * @throws Exception
	 */
	public void deleteFileList(BoardFile boardFileVO) throws Exception{
	    update("board.deleteFileList", boardFileVO);
	}
	 
	
	/** 
	 * @param boardFileVO
	 * @throws Exception
	 */
	public void updateFile(BoardFile boardFileVO) throws Exception{
	    update("board.updateFile", boardFileVO);
	}
	
	/** 
	 * @param boardFileVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteFile(BoardFile boardFileVO) throws Exception{
	    return (Integer) update("board.deleteFile", boardFileVO);
	}
	
	/** 
	 * @param boardVO
	 * @return int
	 * @throws Exception
	 */
	public int updateStatus(Board boardVO) throws Exception{
	    return  (Integer) update("board.updateStatus", boardVO);
	}




	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int selectDownloadCount(BoardDownload boardDownloadVO) throws Exception{
	    return (Integer) selectOne("board.selectDownloadCount", boardDownloadVO);
	}
	
	/** 
	 * @param boardDownloadVO
	 * @return List<BoardDownload>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardDownload> selectDownloadList(BoardDownload boardDownloadVO) throws Exception{
	    return (List<BoardDownload>)selectList("board.selectDownloadList", boardDownloadVO);
	}
	

	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int selectDownloadDeleteCount(BoardDownload boardDownloadVO) throws Exception{
	    return (Integer) selectOne("board.selectDownloadDeleteCount", boardDownloadVO);
	}
	
	/** 
	 * @param boardDownloadVO
	 * @return List<BoardDownload>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<BoardDownload> selectDownloadDeleteList(BoardDownload boardDownloadVO) throws Exception{
	    return (List<BoardDownload>)selectList("board.selectDownloadDeleteList", boardDownloadVO);
	}
	
	
	/** 
	 * @param boardDownloadVO
	 * @throws Exception
	 */
	public void deleteDownloadAll(BoardDownload boardDownloadVO) throws Exception{
	    update("board.deleteDownloadAll", boardDownloadVO);
	}
	
	/** 
	 * @param boardDownloadVO
	 * @return int
	 * @throws Exception
	 */
	public int insertDownload(BoardDownload boardDownloadVO) throws Exception {
		return (int) insert("board.insertDownload", boardDownloadVO);
	}
}