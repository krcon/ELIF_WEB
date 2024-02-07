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
import com.krcon.elif.dao.ProjectDAO;
import com.krcon.elif.vo.Project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Service("projectService")
public class ProjectServiceImpl implements ProjectService{
	Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource(name="projectDAO")
    private ProjectDAO projectDAO;

	
    /** 
     * @param projectVO
     * @return int
     * @throws Exception
     */
    public int selectProjectCount(Project projectVO) throws Exception {
	    return projectDAO.selectProjectCount(projectVO);
	}
	
    
    /** 
     * @param projectVO
     * @return List<Project>
     * @throws Exception
     */
    @Override
    public List<Project> selectProjectList(Project projectVO) throws Exception {
        return projectDAO.selectProjectList(projectVO);
    }
    
    /** 
     * @param projectVO
     * @return Project
     * @throws Exception
     */
    @Override
    public Project selectProjectDetail(Project projectVO) throws Exception {
        return projectDAO.selectProjectDetail(projectVO);
    }
	
    
	
    /** 
     * @param Map<String
     * @param map
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    // ! 마이엘리프
    @Override
    public List<Map<String, Object>> selectMyElifProject(Map<String, Object> map) throws Exception {
        return projectDAO.selectMyElifProject(map);
    }
    
    /** 
     * @param Map<String
     * @param map
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectMyElifProjectDong(Map<String, Object> map) throws Exception {
        return projectDAO.selectMyElifProjectDong(map);
    }
    
    /** 
     * @param Map<String
     * @param map
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    @Override
    public List<Map<String, Object>> selectMyElifProjectHosu(Map<String, Object> map) throws Exception {
        return projectDAO.selectMyElifProjectHosu(map);
    }
    
	
    /** 
     * @param map
     * @return int
     * @throws Exception
     */
    // * 분양계약 일치 여부확인
	public int selectMyElifProjectCount(Map<String, Object> map) throws Exception {
	    return projectDAO.selectMyElifProjectCount(map);
	}
	
    /** 
     * @param map
     * @return int
     * @throws Exception
     */
    // * 계약정보 등록여부 확인
	public int selectMyElifProjectInfoCount(Map<String, Object> map) throws Exception {
	    return projectDAO.selectMyElifProjectInfoCount(map);
	}
	
    /** 
     * @param Map<String
     * @param map
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    // * 계약정보조회
    @Override
    public List<Map<String, Object>> selectMyElifProjectInfoList(Map<String, Object> map) throws Exception {
        return projectDAO.selectMyElifProjectInfoList(map);
    }
	
    /** 
     * @param map
     * @return int
     * @throws Exception
     */
    // * 계약정보 저장
	public int insertMyElifProjectInfo(Map<String, Object> map) throws Exception {
	    return projectDAO.insertMyElifProjectInfo(map);
	}
	
    /** 
     * @param map
     * @return int
     * @throws Exception
     */
    // * 계약정보 삭제
	public int deleteMyElifProjectInfo(Map<String, Object> map) throws Exception {
	    return projectDAO.deleteMyElifProjectInfo(map);
	}
	
    /** 
     * @param Map<String
     * @param map
     * @return List<Map<String, Object>>
     * @throws Exception
     */
    // * 분양대금 조회
    @Override
    public List<Map<String, Object>> selectMyElifPresale(Map<String, Object> map) throws Exception {
        return projectDAO.selectMyElifPresale(map);
    }
}	