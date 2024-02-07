package com.krcon.elif.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import com.krcon.elif.vo.Project;

public interface ProjectService {
	// * 프로젝트 갯수
	int selectProjectCount(Project popupVO) throws Exception;
	// * 프로젝트 리스트
	List<Project> selectProjectList(Project popupVO) throws Exception;
	Project selectProjectDetail(Project popupVO) throws Exception;
	

	// ! 마이엘리프
	// * 프로젝트코드 조회
	List<Map<String, Object>> selectMyElifProject(Map<String, Object> map) throws Exception;
	// * 프로젝트코드 동 조회
	List<Map<String, Object>> selectMyElifProjectDong(Map<String, Object> map) throws Exception;
	// * 프로젝트코드 호수 조회
	List<Map<String, Object>> selectMyElifProjectHosu(Map<String, Object> map) throws Exception;


	// * 분양계약 일치 여부확인
	int selectMyElifProjectCount(Map<String, Object> map) throws Exception;
	// * 계약정보 등록여부 확인
	int selectMyElifProjectInfoCount(Map<String, Object> map) throws Exception;
	// * 계약정보조회
	List<Map<String, Object>> selectMyElifProjectInfoList(Map<String, Object> map) throws Exception;
	// * 계약정보 저장
	int insertMyElifProjectInfo(Map<String, Object> map) throws Exception;
	// * 계약정보 삭제
	int deleteMyElifProjectInfo(Map<String, Object> map) throws Exception;
	// * 분양대금 조회
	List<Map<String, Object>> selectMyElifPresale(Map<String, Object> map) throws Exception;

}