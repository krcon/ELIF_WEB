package com.krcon.elif.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDb2DAO;
 
@Repository("reservationDAO")
public class ReservationDAO extends AbstractDb2DAO{
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveBfChkReserveDong(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveBfChkReserveDong", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveeBfChkReserveHo(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveeBfChkReserveHo", map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public Map<String, Object> retrieveBkchkRsltCode(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("reservation.retrieveBkchkRsltCode", map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public Map<String, Object> retrieveRicheBfchkReserveInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("reservation.retrieveRicheBfchkReserveInfo", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheBfchkReserveInfoList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheBfchkReserveInfoList", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheBfchkReserveDay(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheBfchkReserveDay", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheBfchkReserveCnt(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheBfchkReserveCnt", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int saveRicheBfchkReserve(Map<String, Object> map) throws Exception{
	    return (Integer) update("reservation.saveRicheBfchkReserve", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int cancelRicheBfchkReserve(Map<String, Object> map) throws Exception{
	    return (Integer) update("reservation.cancelRicheBfchkReserve", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> saveRicheBfchkReserveSuccessSmsD(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.saveRicheBfchkReserveSuccessSmsD", map);
	}

	/**
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> retrieveRicheBfchkReserveSmsInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("reservation.retrieveRicheBfchkReserveSmsInfo", map);
	}

	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveDong(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveDong", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveHo(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveHo", map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public Map<String, Object> retrieveMiblRsltCode(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("reservation.retrieveMiblRsltCode", map);
	}
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public Map<String, Object> retrieveRicheMiblReserveInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("reservation.retrieveRicheMiblReserveInfo", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveInfoList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveInfoList", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveDay(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveDay", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveDayDtl(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveDayDtl", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> retrieveRicheMiblReserveCnt(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("reservation.retrieveRicheMiblReserveCnt", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int saveRicheMiblReserve(Map<String, Object> map) throws Exception{
	    return (Integer) update("reservation.saveRicheMiblReserve", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int cancelRicheMiblReserve(Map<String, Object> map) throws Exception{
	    return (Integer) update("reservation.cancelRicheMiblReserve", map);
	}

	/**
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> retrieveRicheMiblReserveSmsInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("reservation.retrieveRicheMiblReserveSmsInfo", map);
	}

	/**
	 * @param Map<String
	 * @param map
	 * @return void
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void sendSms(Map<String, Object> map) throws Exception{
		insert("reservation.sendSms", map);
	}



}