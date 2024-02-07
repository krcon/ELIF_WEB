package com.krcon.elif.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.krcon.elif.common.dao.AbstractDAO;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AccountIp;
 
@Repository("accountDAO")
public class AccountDAO extends AbstractDAO{
	
	
	/** 
	 * @param username
	 * @return Account
	 * @throws Exception
	 */
	public Account login(String username) throws Exception{
	    return (Account) selectOne("adminMember.login", username);
	}
	
	
	/** 
	 * @param id
	 * @return List<String>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<String> selectMemberAuth(String id) throws Exception{
	    return (List<String>) selectList("adminMember.loginAuth", id);
	}
	
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int emailSearch(Account account) throws Exception{
	    return (int) selectOne("adminMember.emailSearch", account);
	}
	
	/** 
	 * @param account
	 * @return List<Account>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Account> selectMemberList(Account account) throws Exception{
	    return (List<Account>)selectList("adminMember.selectMemberList", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void insertMember(Account account) throws Exception{
	    insert("adminMember.insertMember", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void insertMemberAuth(Account account) throws Exception{
	    insert("adminMember.insertMemberAuth", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void insertMemberLogIn(Account account) throws Exception{
	    insert("adminMember.insertMemberLogIn", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void insertMemberLog(Account account) throws Exception{
	    insert("adminMember.insertMemberLog", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void updateLogin(Account account) throws Exception{
	    update("adminMember.updateLogin", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void updateFailLogin(Account account) throws Exception{
	    update("adminMember.updateFailLogin", account);
	}

	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int updateMemberPwd(Account account) throws Exception{
	    return (int)update("adminMember.updateMemberPwd", account);
	}
	
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberCount(Account account) throws Exception{
		return (Integer) selectOne("adminMember.selectMemberCount", account);
	}
	
	 
	
	/** 
	 * @param account
	 * @return Account
	 * @throws Exception
	 */
	public Account selectMemberDetail(Account account) throws Exception{
	    return (Account) selectOne("adminMember.selectMemberDetail", account);
	}

	
	/** 
	 * @param account
	 * @return Account
	 * @throws Exception
	 */
	public Account selectMemberTokenDetail(Account account) throws Exception{
	    return (Account) selectOne("adminMember.selectMemberTokenDetail", account);
	}
	
	
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void updateMember(Account account) throws Exception{
	    update("adminMember.updateMember", account);
	}
	
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int updateAccountNonExpired(Account account) throws Exception{
	    return (int) update("adminMember.updateAccountNonExpired", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void updateToken(Account account) throws Exception{
	    update("adminMember.updateToken", account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int updateLoginAuth(Account account) throws Exception{
	    return (int) update("adminMember.updateLoginAuth", account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int updateLoginImsi(Account account) throws Exception{
	    return (int) update("adminMember.updateLoginImsi", account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int updateCredential(Account account) throws Exception{
	    return (int) update("adminMember.updateCredential", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void deleteMember(Account account) throws Exception{
	    update("adminMember.deleteMember", account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	public void deleteMemberAuth(Account account) throws Exception{
	    update("adminMember.deleteMemberAuth", account);
	}
	
	/**
	 * 아이피 접근 권한
	 */

	/** 
	 * @param accountIp
	 * @return int
	 * @throws Exception
	 */
	public void insertIP(AccountIp accountIp) throws Exception{
	    insert("adminMember.insertIP", accountIp);
	}

	
	/** 
	 * @param accountIp
	 * @return int
	 * @throws Exception
	 */
	public int selectIPSearch(AccountIp accountIp) throws Exception{
	    return (Integer) selectOne("adminMember.selectIPSearch", accountIp);
	}
	
	/** 
	 * @param accountIp
	 * @return List<AccountIp>
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AccountIp> selectIP(AccountIp accountIp) throws Exception{
	    return (List<AccountIp>)selectList("adminMember.selectIP", accountIp);
	}
	
	/** 
	 * @param accountIp
	 * @throws Exception
	 */
	public void updateIP(AccountIp accountIp) throws Exception{
	    update("adminMember.updateIP", accountIp);
	}
	
	/** 
	 * @param accountIp
	 * @throws Exception
	 */
	public void deleteIP(AccountIp accountIp) throws Exception{
	    update("adminMember.deleteIP", accountIp);
	}
	
}