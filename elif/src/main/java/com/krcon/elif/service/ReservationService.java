package com.krcon.elif.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ReservationService {
	List<Map<String, Object>> retrieveBfChkReserveDong(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveeBfChkReserveHo(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveBkchkRsltCode(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveRicheBfchkReserveInfo(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheBfchkReserveInfoList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheBfchkReserveDay(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheBfchkReserveCnt(Map<String, Object> map) throws Exception;
	int saveRicheBfchkReserve(Map<String, Object> map) throws Exception;
	int cancelRicheBfchkReserve(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> saveRicheBfchkReserveSuccessSmsD(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveRicheBfchkReserveSmsInfo(Map<String, Object> map) throws Exception;


	
	List<Map<String, Object>> retrieveRicheMiblReserveDong(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheMiblReserveHo(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveMiblRsltCode(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveRicheMiblReserveInfo(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheMiblReserveDay(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheMiblReserveInfoList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheMiblReserveDayDtl(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> retrieveRicheMiblReserveCnt(Map<String, Object> map) throws Exception;
	int saveRicheMiblReserve(Map<String, Object> map) throws Exception;
	int cancelRicheMiblReserve(Map<String, Object> map) throws Exception;
	Map<String, Object> retrieveRicheMiblReserveSmsInfo(Map<String, Object> map) throws Exception;
	void sendSms(Map<String, Object> map) throws Exception;
}