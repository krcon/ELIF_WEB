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

import com.krcon.elif.dao.MemberDAO;
import com.krcon.elif.vo.Member;

@Configuration
@PropertySource("classpath:system.properties")

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.mail.address}")
    private String mailFrom;
	
	@Autowired
    public JavaMailSender mailSender;
	
    @Resource(name="memberDAO")
    private MemberDAO memberDao;

	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberCount(Member member) throws Exception {
	    return memberDao.selectMemberCount(member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberDupCount(Member member) throws Exception {
	    return memberDao.selectMemberDupCount(member);
	}
    
	/** 
	 * @param member
	 * @return List<Member>
	 * @throws Exception
	 */
	public List<Member> selectMemberList(Member member) throws Exception {
        return memberDao.selectMemberList(member);
    }
    
	/** 
	 * @param member
	 * @return Member
	 * @throws Exception
	 */
	public Member selectMemberDetail(Member member) throws Exception {
        return memberDao.selectMemberDetail(member);
    }

	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int insertMember(Member member) throws Exception {
	    return memberDao.insertMember(member);
	}

	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMember(Member member) throws Exception {
	    return memberDao.updateMember(member);
	}
	
	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateLogin(Member member) throws Exception{
	    return memberDao.updateLogin(member);
	}	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMemberPwd(Member member) throws Exception{
	    return memberDao.updateMemberPwd(member);
	}	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMemberPwdDormancy(Member member) throws Exception{
	    return memberDao.updateMemberPwdDormancy(member);
	}	
    
	/** 
	 * @param member
	 * @return List<Member>
	 * @throws Exception
	 */
	public List<Member> selectMemberDormancy(Member member) throws Exception {
        return memberDao.selectMemberDormancy(member);
    }
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int dormancyEmailMember(Member member) throws Exception{
	    return memberDao.dormancyEmailMember(member);
	}	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int dormancyMember(Member member) throws Exception{
	    return memberDao.dormancyMember(member);
	}	
	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int deleteMember(Member member) throws Exception{
		if(insertMemberSecede(member)>0){
			return memberDao.deleteMember(member);
		}else{
			return 0;
		}
	}
	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int insertMemberSecede(Member member) throws Exception {
	    return memberDao.insertMemberSecede(member);
	}
}	
