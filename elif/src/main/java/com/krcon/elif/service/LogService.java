package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.Log;
public interface LogService {
	List<Log> selectLogInList(Log logVO) throws Exception;
    int selectLogInCount(Log logVo) throws Exception;
    Log selectLogInDetail(Log logVO) throws Exception;
    int insertLogIn(Log logVo) throws Exception;
    int deleteLogIn(Log logVO) throws Exception;
    

    List<Log> selectLogList(Log logVO) throws Exception;
    int selectLogCount(Log logVo) throws Exception;
    Log selectLogDetail(Log logVO) throws Exception;
    int insertLog(Log logVO) throws Exception;
    int deleteLog(Log logVO) throws Exception;
    

    List<Log> selectLogGrantList(Log logVO) throws Exception;
    int selectLogGrantCount(Log logVo) throws Exception;
    Log selectLogGrantDetail(Log logVO) throws Exception;
    int insertLogGrant(Log logVo) throws Exception;
    int deleteLogGrant(Log logVO) throws Exception;
    

    List<Log> selectLogExcelList(Log logVO) throws Exception;
    int selectLogExcelCount(Log logVo) throws Exception;
    Log selectLogExcelDetail(Log logVO) throws Exception;
    int insertLogExcel(Log logVO) throws Exception;
    int deleteLogExcel(Log logVO) throws Exception;
}