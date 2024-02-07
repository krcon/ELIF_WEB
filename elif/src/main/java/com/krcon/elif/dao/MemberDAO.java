package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Member;
 
@Repository("memberDAO")
public class MemberDAO extends AbstractDAO{
	
	
	/** 
	 * @param username
	 * @return Member
	 * @throws Exception
	 */
	public Member login(String username) throws Exception{
	    return (Member) selectOne("member.login", username);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberCount(Member member) throws Exception{
		return (Integer) selectOne("member.selectMemberCount", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberDupCount(Member member) throws Exception{
		return (Integer) selectOne("member.selectMemberDupCount", member);
	}
	
	/** 
	 * @param member
	 * @return List<Member>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Member> selectMemberList(Member member) throws Exception{
	    return (List<Member>)selectList("member.selectMemberList", member);
	}
	
	/** 
	 * @param member
	 * @return Member
	 * @throws Exception
	 */
	public Member selectMemberDetail(Member member) throws Exception{
	    return (Member) selectOne("member.selectMemberDetail", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int insertMember(Member member) throws Exception{
	    return (int) insert("member.insertMember", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int updateMember(Member member) throws Exception{
	    return (int) update("member.updateMember", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int updateLogin(Member member) throws Exception{
	    return (int) update("member.updateLogin", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int updateMemberPwd(Member member) throws Exception{
	    return (int) update("member.updateMemberPwd", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int updateMemberPwdDormancy(Member member) throws Exception{
	    return (int) update("member.updateMemberPwdDormancy", member);
	}

	
	/** 
	 * @param member
	 * @return List<Member>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Member> selectMemberDormancy(Member member) throws Exception{
	    return (List<Member>)selectList("member.selectMemberDormancy", member);
	}
	
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int dormancyMember(Member member) throws Exception{
	    return (int) update("member.dormancyMember", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int dormancyEmailMember(Member member) throws Exception{
	    return (int) update("member.dormancyEmailMember", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int deleteMember(Member member) throws Exception{
	    return (int) update("member.deleteMember", member);
	}
	
	/** 
	 * @param member
	 * @return int
	 * @throws Exception
	 */
	public int insertMemberSecede(Member member) throws Exception{
	    return (int) insert("member.insertMemberSecede", member);
	}
}