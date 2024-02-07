package com.krcon.elif.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AccountIp;

public interface AccountService {
	UserDetails loadUserByUsername(String username) throws Exception;
	
	List<Account> selectMemberList(Account account) throws Exception;
	void insertMember(Account account) throws Exception;
	Account selectMemberDetail(Account account) throws Exception;
	Account selectMemberTokenDetail(Account account) throws Exception;
    void updateMember(Account account) throws Exception;
    int updateAccountNonExpired(Account account) throws Exception;
    int updateMemberPwd(Account account) throws Exception;
    void updateToken(Account account) throws Exception;
    int updateCredential(Account account) throws Exception;
    int updateLoginAuth(Account account) throws Exception;
    int updateLoginImsi(Account account) throws Exception;
    void deleteMember(Account account) throws Exception;
    int selectMemberCount(Account account) throws Exception;
    Account login(Account account) throws Exception;
    int emailSearch(Account account) throws Exception;

    void loginCnt(Account account) throws Exception;
    void loginFailCnt(Account account) throws Exception;

	/**
	 * 아이피 접근 권한
	 */
	void insertIP(AccountIp accountIp) throws Exception;
    int selectIPSearch(AccountIp accountIp) throws Exception;
    List<AccountIp> selectIP(AccountIp accountIp) throws Exception;
    void updateIP(AccountIp accountIp) throws Exception;
    void deleteIP(AccountIp accountIp) throws Exception;

}