package com.krcon.elif.service;

import java.util.List;

import javax.annotation.Resource;

import com.krcon.elif.dao.LogDAO;
import com.krcon.elif.vo.Log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("logService")
public class LogServiceImpl implements LogService{
	Logger log = LoggerFactory.getLogger(this.getClass());
	
    @Resource(name="logDAO")
    private LogDAO logDAO;

    
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@Override
    public List<Log> selectLogInList(Log logVO) throws Exception {
        return logDAO.selectLogInList(logVO);
    }
    
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int selectLogInCount(Log logVo) throws Exception {
	    return logDAO.selectLogInCount(logVo);
	}

    
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	@Override
    public Log selectLogInDetail(Log logVO) throws Exception {
        return logDAO.selectLogInDetail(logVO);
    }

	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertLogIn(Log logVo) throws Exception {
	    return logDAO.insertLogIn(logVo);
	}

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteLogIn(Log logVO) throws Exception{
	    return logDAO.deleteLogIn(logVO);
	}
	

    
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@Override
    public List<Log> selectLogList(Log logVO) throws Exception {
        return logDAO.selectLogList(logVO);
    }
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int selectLogCount(Log logVo) throws Exception {
	    return logDAO.selectLogCount(logVo);
	}
    
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	@Override
    public Log selectLogDetail(Log logVO) throws Exception {
        return logDAO.selectLogDetail(logVO);
    }

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertLog(Log logVO) throws Exception {
	    return logDAO.insertLog(logVO);
	}

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteLog(Log logVO) throws Exception{
	    return logDAO.deleteLog(logVO);
	}
	

    
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@Override
    public List<Log> selectLogGrantList(Log logVO) throws Exception {
        return logDAO.selectLogGrantList(logVO);
    }
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int selectLogGrantCount(Log logVo) throws Exception {
	    return logDAO.selectLogGrantCount(logVo);
	}
    
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	@Override
    public Log selectLogGrantDetail(Log logVO) throws Exception {
        return logDAO.selectLogGrantDetail(logVO);
    }

	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertLogGrant(Log logVo) throws Exception {
	    return logDAO.insertLogGrant(logVo);
	}

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteLogGrant(Log logVO) throws Exception{
	    return logDAO.deleteLogGrant(logVO);
	}
	

    
	/** 
	 * @param logVO
	 * @return List<Log>
	 * @throws Exception
	 */
	@Override
    public List<Log> selectLogExcelList(Log logVO) throws Exception {
        return logDAO.selectLogExcelList(logVO);
    }
	
	/** 
	 * @param logVo
	 * @return int
	 * @throws Exception
	 */
	public int selectLogExcelCount(Log logVo) throws Exception {
	    return logDAO.selectLogExcelCount(logVo);
	}
    
	/** 
	 * @param logVO
	 * @return Log
	 * @throws Exception
	 */
	@Override
    public Log selectLogExcelDetail(Log logVO) throws Exception {
        return logDAO.selectLogExcelDetail(logVO);
    }

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int insertLogExcel(Log logVO) throws Exception {
	    return logDAO.insertLogExcel(logVO);
	}

	
	/** 
	 * @param logVO
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int deleteLogExcel(Log logVO) throws Exception{
	    return logDAO.deleteLogExcel(logVO);
	}
	
}	
