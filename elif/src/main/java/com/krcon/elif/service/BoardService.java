package com.krcon.elif.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.krcon.elif.vo.BoardCate;
import com.krcon.elif.vo.BoardCateCode;
import com.krcon.elif.vo.Board;
import com.krcon.elif.vo.BoardFile;
import com.krcon.elif.vo.BoardDownload;

public interface BoardService {
	List<BoardCate> selectBoardCategory(BoardCate boardCateVO) throws Exception;
	List<BoardCate> selectBoardShortCategory(BoardCate boardCateVO) throws Exception;
	int selectBoardCategorySlug(String str) throws Exception;
	String selectBoardCategoryIpSlug(Integer str) throws Exception;
	int selectBoardCateCntSlug(BoardCate boardCateVO) throws Exception;
    BoardCate selectBoardCategoryDetail(BoardCate boardCateVO) throws Exception;
	void insertCategory(BoardCate boardCateVO, HttpServletRequest request) throws Exception;
    void updateCategory(BoardCate boardCateVO, HttpServletRequest request) throws Exception;
    void deleteCategory(BoardCate boardCateVO) throws Exception;
    
    List<BoardCateCode> selectBoardCateCode(BoardCateCode boardCateCodeVO) throws Exception;
	int selectBoardCateCodeCnt(BoardCateCode boardCateCodeVO) throws Exception;
    void insertCateCode(BoardCateCode boardCateCodeVO, HttpServletRequest request) throws Exception;
    void updateCateCode(BoardCateCode boardCateCodeVO, HttpServletRequest request) throws Exception;
    void deleteCateCode(BoardCateCode boardCateCodeVO) throws Exception;
    
    
    List<Board> selectBoardList(Board boardVO) throws Exception;
	List<BoardFile> selectFileList(BoardFile boardFileVO) throws Exception;
	int selectBoardSlug(Board boardVO) throws Exception;
	int selectBoardSlugIDX(Board boardVO) throws Exception;
	void insertBoard(Board boardVO, HttpServletRequest request) throws Exception;
	Board selectBoardDetail(Board boardVO) throws Exception;
    void updateBoard(Board boardVO, HttpServletRequest request) throws Exception;
    void deleteBoard(Board boardVO,HttpServletRequest request) throws Exception;
    void deleteFile(BoardFile boardFileVO,HttpServletRequest request) throws Exception;
	int selectBoardCount(Board boardVO) throws Exception;
    int updateHitCnt(Board boardVO) throws Exception;
    int updateStatus(Board boardVO) throws Exception;
	List<String> selectBoardGroupGubun(Board boardVO) throws Exception;
	Board selectBoardDetailPrev(Board boardVO) throws Exception;

	Board selectBoardDetailNext(Board boardVO) throws Exception;

	int selectDownloadCount(BoardDownload boardDownloadVO) throws Exception;
    List<BoardDownload> selectDownloadList(BoardDownload boardDownloadVO) throws Exception;
	int selectDownloadDeleteCount(BoardDownload boardDownloadVO) throws Exception;
    List<BoardDownload> selectDownloadDeleteList(BoardDownload boardDownloadVO) throws Exception;
	void deleteDownloadAll(BoardDownload boardDownloadVO) throws Exception;

	int insertDownload(BoardDownload boardDownloadVO) throws Exception;
}