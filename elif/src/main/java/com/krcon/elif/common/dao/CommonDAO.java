package com.krcon.elif.common.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("commonDAO")
public class CommonDAO extends AbstractDAO{
	
	/** 
	 * @param map
	 * @return Map<String, Object>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
	    return (Map<String, Object>)selectOne("common.selectFileInfo", map);
	}
	
	/** 
	 * @param map
	 * @throws Exception
	 */
	public void updateDownloadCnt(Map<String, Object> map) throws Exception{
	     selectOne("common.updateDownloadCnt", map);
	}
}