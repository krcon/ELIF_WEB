package com.krcon.elif.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import com.krcon.elif.vo.Popup;
import com.krcon.elif.vo.PopupFile;

public interface PopupService {
	List<Popup> selectBoardList(Popup popupVO) throws Exception;
	List<PopupFile> selectFileList(PopupFile popupFileVO) throws Exception;
	int selectBoardCount(Popup popupVO) throws Exception;
	void insertBoard(Popup popupVO, HttpServletRequest request) throws Exception;
	Popup selectBoardDetail(Popup popupVO) throws Exception;
    void updateBoard(Popup popupVO, HttpServletRequest request) throws Exception;
    void deleteBoard(Popup popupVO, HttpServletRequest request) throws Exception;
    void deleteFile(PopupFile popupFileVO) throws Exception;
}