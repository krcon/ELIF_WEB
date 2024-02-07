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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.krcon.elif.pagination.PaginationInfo;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;


public class AbstractDAO {
	@Value("${sys.log.query}")
    private String useQueryLog;
    protected Log log = LogFactory.getLog(AbstractDAO.class);
    /*
    @Resource(name="sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;
    */
	@Autowired
	@Qualifier("db1SqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
    List<String> insertList = new ArrayList<String>();
    List<String> selectList = new ArrayList<String>();
    String[] selectCondition = null;
    String[] insertCondition = null;
    Map<String, String> nonDBMenu = new HashMap<String, String>();
    {
		selectList.add("/mgmt/product");
    	selectList.add("/mgmt/board");
    	selectList.add("/mgmt/user");
    	selectList.add("/mgmt/grant");
    	selectList.add("/mgmt/log");
    	selectList.add("/mgmt/popup");
    	selectList.add("/mgmt/solution");
    	selectList.add("/mgmt/customer");
    	selectList.add("/mgmt/product");
		insertList.add("/mgmt/product");
		
		selectCondition = selectList.toArray(new String[selectList.size()]);
		insertCondition = insertList.toArray(new String[insertList.size()]);
		
		nonDBMenu.put("/mgmt/customer/general", "파트너쉽 문의");
		nonDBMenu.put("/mgmt/customer/partner", "개발 문의");
		nonDBMenu.put("/mgmt/product/code/char", "개별코드관리[특성]");
		nonDBMenu.put("/mgmt/product/code/app", "개별코드관리[용도]");
		nonDBMenu.put("/mgmt/product/class/char", "분류코드관리[특성]");
		nonDBMenu.put("/mgmt/product/class/app", "분류코드관리[용도]");
		nonDBMenu.put("/mgmt/product/class/app", "분류코드관리[용도]");
		nonDBMenu.put("/mgmt/log/menu", "메뉴이용기록");
		nonDBMenu.put("/mgmt/log/excel", "엑셀 다운로드기록");
		
		// log.info("###### Creating Query LogMenu....Select Menu:" + selectCondition.length + "건 , Inert Menu:" + insertCondition.length + " 건");
		
		
    }
    
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
        insertQueryLog(queryId, params, "I");
        return sqlSession.insert(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object update(String queryId, Object params){
        printQueryId(queryId);
        insertQueryLog(queryId, params, "I");
        return sqlSession.update(queryId, params);
    }
     
    
	/** 
	 * @param queryId
	 * @param params
	 * @return Object
	 */
	public Object delete(String queryId, Object params){
    	log.info(queryId);
        printQueryId(queryId);
        insertQueryLog(queryId, params, "I");
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
        insertQueryLog(queryId, params, "S");
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
        insertQueryLog(queryId, params, "S");
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
        insertQueryLog(queryId, params, "S");
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
    
    /***
     * 쿼리 실행시 실행쿼리 DB 저장하기
     * */
    protected void insertQueryLog(String queryId, Object params, String gubun) {
    	//log.info("# 쿼리로그 실행여부 :" + useQueryLog + ", ExeLog gubun:" + gubun);
    	if("Y".equals(useQueryLog)) {
	    	if("S".equals(gubun)){
	    		if(selectCondition != null) {
	    			exeLog(queryId, params, selectCondition);
	    		}else {
	    			log.info("# selectCondition is null");
	    		}
	    	}else if("I".equals(gubun)){
	    		if(insertCondition != null) {
	    			exeLog(queryId, params, insertCondition);
	    		}else {
	    			log.info("# insertCondition is null");
	    		}
			}
    	}
    }
    /***
     *  DB 저장 실행
     * */
    private void exeLog(String queryId, Object params, String[] exeCondition) {
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	log.info(auth);
        if(auth != null) {
        	if(!auth.getPrincipal().equals("anonymousUser")) {
				Account principal = (Account) auth.getPrincipal();
				String requestedMenu = principal.getRequested_menu();
				if(requestedMenu != null) {
					if(Arrays.stream(exeCondition).anyMatch(requestedMenu::contains)) {
						String menuName = "";
						for(AdminMenu menu : principal.getAllMenu()) {
							//log.info("Menu URL:" + menu.getUrl());
							if(requestedMenu.equals(menu.getUrl())) {
								menuName = menu.getName();
								break;
							}
						}
						//String menuName = (principal.getAllMenu().stream().filter(menu -> requestedMenu.equals(menu.getUrl())).findAny().orElse(null)).getName();
						log.info("================ Query Log Info Start=======================");
						log.info("queryId:" + queryId);
						log.info("Requested menu:" + requestedMenu);
						log.info("menuName:" + menuName);
				        log.info("================ Query Log Info End=======================");
	
				        if("".equals(menuName)) {
				        	menuName = nonDBMenu.get(requestedMenu);
				        }
				        if("".equals(menuName) || menuName == null) {
				        	log.info("================ Query Log 실행안함 [접근메뉴명을 획득실패]=======================");
				        }else {
				        	String sql = sqlSession.getConfiguration().getMappedStatement(queryId).getBoundSql(params).getSql();
				        	List<ParameterMapping> mappedParam = sqlSession.getConfiguration().getMappedStatement(queryId).getBoundSql(params).getParameterMappings();
				            //log.info("## insert query:\n" + sql);
				        	Map<String, Object> logParam = new HashMap<String, Object>();
					        logParam.put("login_ip", principal.getLogin_ip());
					        logParam.put("access_menu", menuName);
					        logParam.put("description", makeSql(params, sql, mappedParam));
					        logParam.put("userid", principal.getUserid());
					        sqlSession.insert("adminLog.insertLog", logParam);
				        }
					}
				}
        	}
	    }	
    }
    /***
     * SQL 문장 만들기
     * */
	private String makeSql(Object params, String sql, List<ParameterMapping> mappedParam) {
		if(params == null){                
		    sql = sql.replaceFirst("\\?", "''");
		}else{
		    if(params instanceof Integer || params instanceof Long || params instanceof Float || params instanceof Double){
		        sql = sql.replaceFirst("\\?", params.toString());
		    }else if(params instanceof String){    
		        sql = sql.replaceFirst("\\?", "'" + params + "'");
		    }else if(params instanceof Map){        
		        
		        for(ParameterMapping mapping : mappedParam){
		            String propValue = mapping.getProperty();
					@SuppressWarnings("rawtypes")
		            Object value = ((Map) params).get(propValue);    
		            if(value != null){
		                if(value instanceof String){            
		                    sql = sql.replaceFirst("\\?", "'" + value + "'");
		                }else{
		                    sql = sql.replaceFirst("\\?", value.toString());
		                }
		            }else{
		                sql = sql.replaceFirst("\\?", "'null'");
		            }
		            
		        }
		    }else{
		        
		        Class<? extends Object> paramClass = params.getClass();
		        for(ParameterMapping mapping : mappedParam){
		            String propValue = mapping.getProperty();
		            Field field;
					try {
						field = paramClass.getDeclaredField(propValue);
					    field.setAccessible(true);                    
		                Class<?> javaType = mapping.getJavaType();            
//			                        log.info("##################### propValue:" + propValue);
//			                        log.info("##################### javaType:" + javaType);
		                
		                if(String.class == javaType){                
		                    sql = sql.replaceFirst("\\?", "'" + field.get(params) + "'");
		                }else{
		                	if(field.get(params) == null) {
		                		sql = sql.replaceFirst("\\?", "");
		                	}else {
		                		sql = sql.replaceFirst("\\?", "'" + field.get(params) + "'");
		                	}
		                }
					} catch (NoSuchFieldException | SecurityException | IllegalArgumentException | IllegalAccessException e) {
						e.printStackTrace();
					}   
		        }
		    }
		}
		return sql;
	}
}
