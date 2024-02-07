package com.krcon.elif.service;

import java.util.List;

import com.krcon.elif.vo.Member;
public interface MemberService {
    int selectMemberCount(Member member) throws Exception;
    int selectMemberDupCount(Member member) throws Exception;
	List<Member> selectMemberList(Member member) throws Exception;
    Member selectMemberDetail(Member member) throws Exception;
    int insertMember(Member member) throws Exception;
    int updateMember(Member member) throws Exception;
    int updateLogin(Member member) throws Exception;
    int updateMemberPwd(Member member) throws Exception;
    int updateMemberPwdDormancy(Member member) throws Exception;
	List<Member> selectMemberDormancy(Member member) throws Exception;
    int dormancyMember(Member member) throws Exception;
    int dormancyEmailMember(Member member) throws Exception;
    int deleteMember(Member member) throws Exception;


    int insertMemberSecede(Member member) throws Exception;
}