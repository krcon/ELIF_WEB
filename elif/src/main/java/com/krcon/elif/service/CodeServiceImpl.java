package com.krcon.elif.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krcon.elif.dao.CodeDAO;
import com.krcon.elif.vo.Code;

@Configuration
@PropertySource("classpath:system.properties")

@Service("codeService")
public class CodeServiceImpl implements CodeService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.mail.address}")
    private String mailFrom;
	
	@Autowired
    public JavaMailSender mailSender;
	
    @Resource(name="codeDAO")
    private CodeDAO codeDao;

    
	/** 
	 * @param code
	 * @return List<Code>
	 * @throws Exception
	 */
	public List<Code> selectCode(Code code) throws Exception {
        return codeDao.selectCode(code);
    }
    
    
	/** 
	 * @param code
	 * @return List<Code>
	 * @throws Exception
	 */
	public List<Code> selectCodeList(Code code) throws Exception {
        return codeDao.selectCodeList(code);
    }
	
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int insertCode(Code code) throws Exception {
	    return codeDao.insertCode(code);
	}

	
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateCode(Code code) throws Exception {
	    return codeDao.updateCode(code);
	}
	
	
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateCodeSort(Code code) throws Exception{
	    return codeDao.updateCodeSort(code);
	}	
	
	
	/** 
	 * @param code
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int deleteCode(Code code) throws Exception{
	    return codeDao.deleteCode(code);
	}
	
}	
