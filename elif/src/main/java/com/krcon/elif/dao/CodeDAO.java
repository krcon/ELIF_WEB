package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Code;
 
@Repository("codeDAO")
public class CodeDAO extends AbstractDAO{

	
	/** 
	 * @param code
	 * @return List<Code>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Code> selectCode(Code code) throws Exception{
	    return (List<Code>)selectList("code.selectCode", code);
	}
	
	/** 
	 * @param code
	 * @return List<Code>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Code> selectCodeList(Code code) throws Exception{
	    return (List<Code>)selectList("code.selectCode", code);
	}
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	public int insertCode(Code code) throws Exception{
	    return (int) insert("code.insertCode", code);
	}
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	public int updateCodeSort(Code code) throws Exception{
		return (int) update("code.updateCodeSort", code);
	}

	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	public int updateCode(Code code) throws Exception{
		return (int) update("code.updateCode", code);
	}
	
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	public int deleteCode(Code code) throws Exception{
		return (int) update("code.deleteCode", code);
	}
	
}