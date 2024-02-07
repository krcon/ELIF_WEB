package com.krcon.elif.common.util;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.apache.commons.beanutils.BeanUtils;
 
/**
 * JSON관련 가공에 필요한 함수들
 * @auther Youngdae Kim 2021. 05. 05.
 */
public class JsonUtil {
	
	//  private final static Logger log = LoggerFactory.getLogger(JsonUtil.class);
    /**
     * 2차원 배열의 부모/자식 관계의 데이터를 트리형식으로 재나열 한다.
     * @param list          2차원 배열
     * @param rootId        최상위 id
     * @param idKey         유니크한 키(id가 될 필드명)
     * @param pIdKey        부모키(pId가 될 필드명)
     * @param titleKey      메뉴명이 표시될 필드명
     * @return
     * @throws JsonProcessingException 
     * @throws JsonMappingException 
     * @auther Youngdae Kim 2021. 05. 05.
     */
    public static List<Map<String, Object>> convertorTreeMap(final List<Map<String, Object>> list, String rootId, final String idKey, final String pIdKey, final String titleKey, final String compareKey) throws JsonMappingException, JsonProcessingException{
        return convertorTreeMap(list, rootId, idKey, pIdKey, titleKey, compareKey, null);
    }
    /**
     * 2차원 배열의 부모/자식 관계의 데이터를 트리형식으로 재나열 한다.
     * @param list          2차원 배열
     * @param rootId        최상위 id
     * @param idKey         유니크한 키(id가 될 필드명)
     * @param pIdKey        부모키(pId가 될 필드명)
     * @param titleKey      메뉴명이 표시될 필드명
     * @param orderKey      정렬이 필요한경우 정령 필드명
     * @return
     * @throws JsonProcessingException 
     * @throws JsonMappingException 
     * @auther Youngdae Kim 2021. 05. 05.
     */
    @SuppressWarnings("unchecked")
	public static List<Map<String, Object>> convertorTreeMap(List inList, String rootId, final String idKey, final String pIdKey, final String titleKey, final String compareKey, final String orderKey) throws JsonMappingException, JsonProcessingException{
        List<Map<String, Object>> treeList = new ArrayList<Map<String,Object>>();   // 최종 트리
        
        ObjectMapper mapper = new ObjectMapper();
		
        //비교할 Array List 가져오기
        Map<String, String> menuMap = new HashMap<String, String>();
        if(compareKey!=null) {
        	menuMap = mapper.readValue(compareKey, Map.class);
        }
    	List<String> menuArray = new ArrayList<String>();
        if(menuMap.size()>0) {
            for( String key : menuMap.keySet() ){
                menuArray.add(key);
                if(menuMap.get(key).toString().length()>0) {
                    String[] convertedMenuArray = menuMap.get(key).split(",");
                    for (String number : convertedMenuArray) {
                    	menuArray.add(number);
                    }
                	
                }
            }	
        }
        
        if( inList == null || inList.size() == 0 )  throw new RuntimeException("List<Map> 데이터가 없습니다.");
        if( inList.get(0) == null )                 throw new RuntimeException("Map 데이터가 없습니다.");
         
        final List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); // 원본데이터(Bean일경우 Map으로 변환)
        Iterator iter;
        for( iter=inList.iterator(); iter.hasNext(); ) {
            try{
                Object obj = iter.next();
                if( obj instanceof Map ) {
                    list.add((Map<String, Object>) obj);
                }else{
                    list.add((Map<String, Object>) BeanUtils.describe(obj));
                }
            }catch (Exception e) {
                throw new RuntimeException("Collection -> List<Map> 으로 변환 중 실패: " + e);
            }
        }
        int listLength = list.size();
        int loopLength = 0;
        final int[] treeLength = new int[] { 0 };
        while ( treeLength[0] != listLength && listLength != loopLength++ ) {
            for ( int i=0; i<list.size(); i++ ) {
                Map<String, Object> item = list.get(i);
                boolean loopBool = true;
                if(menuArray.size()>0) {
                    if(!menuArray.contains(item.get("idx").toString())) {
                    	loopBool = false;
                    }
                }
                if(loopBool) {

                    if ( rootId.equals(item.get(pIdKey).toString()) ) {
                        Map<String, Object> view = new HashMap<String, Object>(item);
                        view.put("title", item.get(titleKey));
                        view.put("children", new ArrayList<Map<String,Object>>());
                         
                        treeList.add(view);
                        list.remove(i);
                         
                        treeLength[0]++;
                         
                         
                        if( orderKey != null ){
                            Collections.sort(treeList, new Comparator<Map<String, Object>>(){
                                public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
                                    return ((String)arg0.get(orderKey)).compareTo((String)arg1.get(orderKey));
                                }
                            });
                        }
                        view.put("isFolder", "true");
                        break;
                    }else{
                        new InnerClass(){
                            public void getParentNode(List<Map<String, Object>> children, Map<String, Object> item ) {
                                for ( int i=0; i<children.size(); i++ ) {
                                    Map<String, Object> child = children.get(i);
                                    if ( child.get(idKey).equals(item.get(pIdKey)) ) {
                                        Map<String, Object> view = new HashMap<String, Object>(item);
                                        view.put("title", item.get(titleKey));
                                        view.put("children", new ArrayList<Map<String,Object>>());
                                        ((List<Map<String,Object>>) child.get("children")).add(view);
                                         
                                        treeLength[0]++;
                                         
                                        list.remove(list.indexOf(item));
                                        view.put("isFolder", "true");
                                         
                                        if( orderKey != null ){
                                            Collections.sort(((List<Map<String,Object>>) child.get("children")), new Comparator<Map<String, Object>>(){
                                                public int compare(Map<String, Object> arg0, Map<String, Object> arg1) {
                                                    return ((String)arg0.get(orderKey)).compareTo((String)arg1.get(orderKey));
                                                }
                                            });
                                        }
                                        break;
                                    }else{
                                        if( ((List<Map<String,Object>>) child.get("children")).size() > 0 ){
                                            getParentNode((List<Map<String,Object>>) child.get("children"), item);
                                        }
                                    }
                                }
                            }
                        }.getParentNode(treeList, item);
                    }
                }
            }
        }
        return treeList;
    }
     
    public interface InnerClass {
        public void getParentNode(List<Map<String, Object>> list, Map<String, Object> item );
    }
     
}