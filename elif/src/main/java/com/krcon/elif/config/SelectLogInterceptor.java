package com.krcon.elif.config;

import java.lang.reflect.Field;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import com.krcon.elif.common.service.CommonService;
import com.krcon.elif.common.util.DirectMybatis;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AdminMenu;
 
@Intercepts({
    @Signature(type=StatementHandler.class, method="query", args={Statement.class, ResultHandler.class})
})
public class SelectLogInterceptor implements Interceptor {
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    Logger log = LoggerFactory.getLogger(this.getClass());
   
    
    /** 
     * @param invocation
     * @return Object
     * @throws Throwable
     */
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
    	
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if(auth != null) {
			Account principal = (Account) auth.getPrincipal();
			String requestedMenu = principal.getRequested_menu();
			if(requestedMenu != null) {
				String execCondition = "/mgmt/product";
				if(requestedMenu.contains(execCondition)) {
					String menuName = "";
					boolean exeSaveLog = false;
					log.info("================Account Info Start=======================");
			        //log.info("keywork:" + principal.getKeyword());
			        //log.info("grants:" + principal.getGrants());
			        //log.info("Menus:" + principal.getMenus());
			        log.info("Requested menu:" + requestedMenu);
			        log.info("================Account Info End=======================");
			        for(AdminMenu menu : principal.getAllMenu()) {
			        	//log.info("Compare Menu:" + menu.getUrl());
						if(menu.getUrl().equals(requestedMenu)) {
							menuName = menu.getName();
							//log.info("Menu Name:" + menuName);
							exeSaveLog = true;
							break;
						}
					}
			        if(exeSaveLog) {
			        	Map<String, Object> logParam = new HashMap<String, Object>();
				        logParam.put("login_ip", principal.getLogin_ip());
				        logParam.put("access_menu", menuName);
				        logParam.put("description", makeSql(invocation));
				        logParam.put("userid", principal.getUserid());
				        SqlSession sess = null;
				        DirectMybatis mybatis = new DirectMybatis();
				        sess = mybatis.createSession();
				        sess.insert("adminLog.insertLog", logParam);
				        sess.close();
				        mybatis.close();
			        }
				}
			}
	    }
        
        return invocation.proceed(); 
    }

	
    /** 
     * @param invocation
     * @return String
     * @throws NoSuchFieldException
     * @throws IllegalAccessException
     */
    private String makeSql(Invocation invocation) throws NoSuchFieldException, IllegalAccessException {
		StatementHandler handler = (StatementHandler)invocation.getTarget();
        BoundSql boundSql = handler.getBoundSql();
        String sql = boundSql.getSql();
        Object param = handler.getParameterHandler().getParameterObject();
        
        if(param == null){                
            sql = sql.replaceFirst("\\?", "''");
        }else{
            if(param instanceof Integer || param instanceof Long || param instanceof Float || param instanceof Double){
                sql = sql.replaceFirst("\\?", param.toString());
            }else if(param instanceof String){    
                sql = sql.replaceFirst("\\?", "'" + param + "'");
            }else if(param instanceof Map){        
                List<ParameterMapping> paramMapping = boundSql.getParameterMappings();    
                
                for(ParameterMapping mapping : paramMapping){
                    String propValue = mapping.getProperty();

		            @SuppressWarnings("rawtypes")
                    Object value = ((Map) param).get(propValue);    
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
                List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
                Class<? extends Object> paramClass = param.getClass();
                for(ParameterMapping mapping : paramMapping){
                    String propValue = mapping.getProperty();            
                    Field field = paramClass.getDeclaredField(propValue);    
                    field.setAccessible(true);                    
                    Class<?> javaType = mapping.getJavaType();            
                    if(String.class == javaType){                
                        sql = sql.replaceFirst("\\?", "'" + field.get(param) + "'");
                    }else{
                    	if(field.get(param) == null) {
                    		sql = sql.replaceFirst("\\?", "");
                    	}else {
                    		sql = sql.replaceFirst("\\?", "'" + field.get(param) + "'");
                    	}
                    }
                }
            }
        }
//      log.info("=====================================================================");
//      log.info("SQL Interceptor: "+sql);
//      log.info("=====================================================================");
        
        return sql;
	}
 
    
    /** 
     * @param target
     * @return Object
     */
    @Override
    public Object plugin(Object target) {
            return Plugin.wrap(target, this);
    }
 
    
    /** 
     * @param properties
     */
    @Override
    public void setProperties(Properties properties) {
        
    }
 
}