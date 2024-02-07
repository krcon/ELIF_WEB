package com.krcon.elif.common.dao;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.mapping.ParameterMapping;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.krcon.elif.pagination.PaginationInfo;


public class AbstractDb2DAO {
    protected Log log = LogFactory.getLog(AbstractDb2DAO.class);

	@Autowired
	@Qualifier("db2SqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

    
	/** 
	 * @param queryId
	 */
	protected void printQueryId(String queryId) {
        if(log.isDebugEnabled()){
            log.debug("\t QueryId  \t:  " + queryId);
        }
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object insert(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession.insert(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object update(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession.update(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object delete(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession.delete(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @return Object
	 */
	public Object selectOne(String queryId){
        printQueryId(queryId);
        return sqlSession.selectOne(queryId);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object selectOne(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession.selectOne(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @return List
	 */
	@SuppressWarnings("rawtypes")
    public List selectList(String queryId){
        printQueryId(queryId);
        return sqlSession.selectList(queryId);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return List
	 */
	@SuppressWarnings("rawtypes")
    public List selectList(String queryId, Object params){
        printQueryId(queryId);
        return sqlSession.selectList(queryId,params);
    }

    
	/** 
	 * @param queryId
	 * @param params
	 * @return Map
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map selectPagingList(String queryId, Object params){
        printQueryId(queryId);
        Map<String,Object> map = (Map<String,Object>)params;

        Map<String,Object> returnMap = new HashMap<String,Object>();
        if("json".equals(map.get("PAGE"))){
	        List<Map<String,Object>> list = sqlSession.selectList(queryId,params);
	        returnMap.put("result", list);
        }else{
        	PaginationInfo paginationInfo = null;
	         
	        if(map.containsKey("currentPageNo") == false || map.get("currentPageNo").toString().isEmpty() == true)
	            map.put("currentPageNo","1");
	        
	        paginationInfo = new PaginationInfo();
	        paginationInfo.setCurrentPageNo(Integer.parseInt(map.get("currentPageNo").toString()));
	        if(map.containsKey("PAGE_ROW") == false || map.get("PAGE_ROW").toString().isEmpty() == true){
	            paginationInfo.setRecordCountPerPage(15);
	        }
	        else{
	            paginationInfo.setRecordCountPerPage(Integer.parseInt(map.get("PAGE_ROW").toString()));
	        }
	        if(map.containsKey("PAGE_SIZE") == false || map.get("PAGE_SIZE").toString().isEmpty() == true){
        		paginationInfo.setPageSize(10);
	        }
	        else{
        		paginationInfo.setPageSize(Integer.parseInt(map.get("PAGE_ROW").toString()));
	        }
	        int start = paginationInfo.getFirstRecordIndex();
	        //oracle
	        //int end = start + paginationInfo.getRecordCountPerPage();
	        //mysql 
	        int end = paginationInfo.getRecordCountPerPage();
	        List<Map<String,Object>> totalList = selectList(queryId,map);
	        map.put("START",start);
	        map.put("END",end);

	        log.info("============");
	        log.info("START::"+map.get("START").toString());
	        log.info("END::"+map.get("END").toString());
	        params = map;
	        
	        List<Map<String,Object>> list = selectList(queryId,params);
	         
	        if(list.size() == 0){
	            map = new HashMap<String,Object>();
	            map.put("TOTAL_COUNT",0);  
	            //list.add(map);
	             
	            if(paginationInfo != null){
	                paginationInfo.setTotalRecordCount(0);
	                returnMap.put("paginationInfo", paginationInfo);
	            }
	        }
	        else{
	            if(paginationInfo != null){
	                //paginationInfo.setTotalRecordCount(Integer.parseInt(list.get(0).get("TOTAL_COUNT").toString()));
	            	
	                paginationInfo.setTotalRecordCount(totalList.size());
	                returnMap.put("paginationInfo", paginationInfo);
	            }
	        }
	        log.info(list.size());
	        log.info("============");
	        returnMap.put("result", list);
        }
        return returnMap;
    }
}
