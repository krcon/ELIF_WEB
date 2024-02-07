package com.krcon.elif.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDb2DAO;
import com.krcon.elif.vo.Project;
 
@Repository("projectDAO")
public class ProjectDAO extends AbstractDb2DAO{
	
	
	/** 
	 * @param projectVO
	 * @return int
	 * @throws Exception
	 */
	public int selectProjectCount(Project projectVO) throws Exception{
	    return (Integer) selectOne("project.selectProjectCount", projectVO);
	}

	
	/** 
	 * @param projectVO
	 * @return List<Project>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Project> selectProjectList(Project projectVO) throws Exception{
	    return (List<Project>)selectList("project.selectProjectList", projectVO);
	}

	
	/** 
	 * @param projectVO
	 * @return Project
	 * @throws Exception
	 */
	public Project selectProjectDetail(Project projectVO) throws Exception{
	    return (Project)selectOne("project.selectProjectDetail", projectVO);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	// ! 마이엘리프

	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectMyElifProject(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectMyElifProject", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectMyElifProjectDong(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectMyElifProjectDong", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectMyElifProjectHosu(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectMyElifProjectHosu", map);
	}


	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int selectMyElifProjectCount(Map<String, Object> map) throws Exception{
	    return (Integer) selectOne("project.selectMyElifProjectCount", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int selectMyElifProjectInfoCount(Map<String, Object> map) throws Exception{
	    return (Integer) selectOne("project.selectMyElifProjectInfoCount", map);
	}
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectMyElifProjectInfoList(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectMyElifProjectInfoList", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int insertMyElifProjectInfo(Map<String, Object> map) throws Exception{
	    return (Integer) insert("project.insertMyElifProjectInfo", map);
	}
	
	/** 
	 * @param map
	 * @return int
	 * @throws Exception
	 */
	public int deleteMyElifProjectInfo(Map<String, Object> map) throws Exception{
	    return (Integer) update("project.deleteMyElifProjectInfo", map);
	}
	
	
	/** 
	 * @param Map<String
	 * @param map
	 * @return List<Map<String, Object>>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked") 
	public List<Map<String, Object>> selectMyElifPresale(Map<String, Object> map) throws Exception{
	    return (List<Map<String, Object>>)selectList("project.selectMyElifPresale", map);
	}

}