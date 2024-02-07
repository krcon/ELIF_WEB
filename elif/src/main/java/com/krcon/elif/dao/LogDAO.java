package com.krcon.elif.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Log;
 
@Repository("logDAO")
public class LogDAO extends AbstractDAO{

	
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Log> selectLogInList(Log logVO) throws Exception{
	    return (List<Log>)selectList("adminLog.selectLogInList", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int selectLogInCount(Log logVO) throws Exception{
	    return (int) selectOne("adminLog.selectLogInCount", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	public Log selectLogInDetail(Log logVO) throws Exception{
	    return (Log) selectOne("adminLog.selectLogInDetail", logVO);
	}
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int insertLogIn(Log logVo) throws Exception{
	    return (int) insert("adminLog.insertLogIn", logVo);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteLogIn(Log logVO) throws Exception{
		return (int) update("adminLog.deleteLogIn", logVO);
	}
	


	
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Log> selectLogList(Log logVO) throws Exception{
	    return (List<Log>)selectList("adminLog.selectLogList", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int selectLogCount(Log logVO) throws Exception{
	    return (int) selectOne("adminLog.selectLogCount", logVO);
	}
	
	
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	public Log selectLogDetail(Log logVO) throws Exception{
	    return (Log) selectOne("adminLog.selectLogDetail", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 */
	public int insertLog(Log logVO){
	    return (int) insert("adminLog.insertLog", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteLog(Log logVO) throws Exception{
		return (int) update("adminLog.deleteLog", logVO);
	}
	


	
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Log> selectLogGrantList(Log logVO) throws Exception{
	    return (List<Log>)selectList("adminLog.selectLogGrantList", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int selectLogGrantCount(Log logVO) throws Exception{
	    return (int) selectOne("adminLog.selectLogGrantCount", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	public Log selectLogGrantDetail(Log logVO) throws Exception{
	    return (Log) selectOne("adminLog.selectLogGrantDetail", logVO);
	}
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int insertLogGrant(Log logVo) throws Exception{
	    return (int) insert("adminLog.insertLogGrant", logVo);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteLogGrant(Log logVO) throws Exception{
		return (int) update("adminLog.deleteLogGrant", logVO);
	}

	
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Log> selectLogExcelList(Log logVO) throws Exception{
	    return (List<Log>)selectList("adminLog.selectLogExcelList", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int selectLogExcelCount(Log logVO) throws Exception{
	    return (int) selectOne("adminLog.selectLogExcelCount", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	public Log selectLogExcelDetail(Log logVO) throws Exception{
	    return (Log) selectOne("adminLog.selectLogExcelDetail", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int insertLogExcel(Log logVO) throws Exception{
	    return (int) insert("adminLog.insertLogExcel", logVO);
	}
	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	public int deleteLogExcel(Log logVO) throws Exception{
		return (int) update("adminLog.deleteLogExcel", logVO);
	}
	
}