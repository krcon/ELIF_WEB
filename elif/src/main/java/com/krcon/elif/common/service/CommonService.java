package com.krcon.elif.common.service;

import java.util.Map;

public interface CommonService {
	Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	void updateDownloadCnt(Map<String, Object> map) throws Exception;
}