package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.Code;
public interface CodeService {
	List<Code> selectCodeList(Code code) throws Exception;
    int insertCode(Code code) throws Exception;
    int updateCode(Code code) throws Exception;
    int updateCodeSort(Code code) throws Exception;
    int deleteCode(Code code) throws Exception;
}