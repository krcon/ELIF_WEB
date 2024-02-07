package com.krcon.elif.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.krcon.elif.common.util.CommonUtils;
import com.krcon.elif.common.util.FileUtils;
import com.krcon.elif.dao.ReservationDAO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Service("reservationService")
public class ReservationServiceImpl implements ReservationService{
	Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource(name="reservationDAO")
    private ReservationDAO reservationDAO;

	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> retrieveBfChkReserveDong(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveBfChkReserveDong(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveeBfChkReserveHo(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveeBfChkReserveHo(map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> retrieveBkchkRsltCode(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveBkchkRsltCode(map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> retrieveRicheBfchkReserveInfo(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheBfchkReserveInfo(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheBfchkReserveInfoList(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheBfchkReserveInfoList(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheBfchkReserveDay(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheBfchkReserveDay(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheBfchkReserveCnt(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheBfchkReserveCnt(map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int saveRicheBfchkReserve(Map<String, Object> map) throws Exception{
	    return reservationDAO.saveRicheBfchkReserve(map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int cancelRicheBfchkReserve(Map<String, Object> map) throws Exception{
	    return reservationDAO.cancelRicheBfchkReserve(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> saveRicheBfchkReserveSuccessSmsD(Map<String, Object> map) throws Exception{
	    return reservationDAO.saveRicheBfchkReserveSuccessSmsD(map);
	}


	/**
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> retrieveRicheBfchkReserveSmsInfo(Map<String, Object> map) throws Exception{
		return reservationDAO.retrieveRicheBfchkReserveSmsInfo(map);
	}

	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveDong(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveDong(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveHo(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveHo(map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> retrieveMiblRsltCode(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveMiblRsltCode(map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	public Map<String, Object> retrieveRicheMiblReserveInfo(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveInfo(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveInfoList(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveInfoList(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveDay(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveDay(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveDayDtl(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveDayDtl(map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override 
	public List<Map<String, Object>> retrieveRicheMiblReserveCnt(Map<String, Object> map) throws Exception{
	    return reservationDAO.retrieveRicheMiblReserveCnt(map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int saveRicheMiblReserve(Map<String, Object> map) throws Exception{
	    return reservationDAO.saveRicheMiblReserve(map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int cancelRicheMiblReserve(Map<String, Object> map) throws Exception{
	    return reservationDAO.cancelRicheMiblReserve(map);
	}

	/**
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> retrieveRicheMiblReserveSmsInfo(Map<String, Object> map) throws Exception{
		return reservationDAO.retrieveRicheMiblReserveSmsInfo(map);
	}

	/**
	 * @param Map<String
	 * @param map
	 * @return void
	 * @throws Exception
	 */
	public void  sendSms(Map<String, Object> map) throws Exception{
		reservationDAO.sendSms(map);
	}
}	