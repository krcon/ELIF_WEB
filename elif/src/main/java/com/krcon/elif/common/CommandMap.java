package com.krcon.elif.common;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class CommandMap {
	Map<String,Object> map = new HashMap<String,Object>();
	
	/** 
	 * @param key
	 * @return Object
	 */
	public Object get(String key){
		return map.get(key);
	}
	
	/** 
	 * @param key
	 * @param value
	 */
	public void put(String key, Object value){
		map.put(key, value);
	}
	
	/** 
	 * @param key
	 * @return Object
	 */
	public Object remove(String key){
		return map.remove(key);
	}
	
	/** 
	 * @param key
	 * @return boolean
	 */
	public boolean containsKey(String key){
		return map.containsKey(key);
	}
	
	/** 
	 * @param value
	 * @return boolean
	 */
	public boolean containsValue(Object value){
		return map.containsValue(value);
	}
	public void clear(){
		map.clear();
	}
	
	/** 
	 * @return Set<Entry<String, Object>>
	 */
	public Set<Entry<String, Object>> entrySet(){
		return map.entrySet();
	}
	
	/** 
	 * @return Set<String>
	 */
	public Set<String> keySet(){
		return map.keySet();
	}
	
	/** 
	 * @return boolean
	 */
	public boolean isEmpty(){
		return map.isEmpty();
	}
	
	/** 
	 * @param m
	 */
	public void putAll(Map<? extends String, ?extends Object> m){
		map.putAll(m);
	}
	
	/** 
	 * @return Map<String, Object>
	 */
	public Map<String,Object> getMap(){
		return map;
	}
}