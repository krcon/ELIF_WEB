package com.krcon.elif.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.krcon.elif.dao.AccountDAO;
import com.krcon.elif.dao.LogDAO;
import com.krcon.elif.vo.Account;
import com.krcon.elif.vo.AccountIp;
import com.krcon.elif.vo.Log;

@Configuration
@PropertySource("classpath:system.properties")

@Service("accountService")
public class AccountServiceImpl implements AccountService{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("${sys.mail.address}")
    private String mailFrom;
	
	@Autowired
    public JavaMailSender mailSender;

    @Resource(name="accountDAO")
    private AccountDAO accountDAO;
    @Resource(name="logDAO")
    private LogDAO logDAO;
    
	
	/** 
	 * @param username
	 * @return UserDetails
	 * @throws Exception
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws Exception {
		log.info("## loadUserByUsername ##"+username);
		Account account = accountDAO.login(username);
		if(account!=null) {
			account.setAuthorities(getAuthorities(username));
		}
		return account;
	}


	
	/** 
	 * @param username
	 * @return Collection<GrantedAuthority>
	 * @throws Exception
	 */
	public Collection<GrantedAuthority> getAuthorities(String username) throws Exception {
		List<String> string_authorities = (List<String>) accountDAO.selectMemberAuth(username);
		if (string_authorities == null) {
			log.info("## 해당 계정에 부여된 권한이 없습니다. ##");
			throw new UsernameNotFoundException(username);
		}
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();

		for (String authority : string_authorities) {
			authorities.add(new SimpleGrantedAuthority(authority));
		}
		return authorities;
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Override
	public int emailSearch(Account account) throws Exception {
	    return accountDAO.emailSearch(account);
	}
	
	/** 
	 * @param account
	 * @return Account
	 * @throws Exception
	 */
	public Account login(Account account) throws Exception {
		account = accountDAO.login(account.getUserid());
	    accountDAO.updateLogin(account);
	    return account;
	}
	
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Override
	public void loginCnt(Account account) throws Exception {
	    accountDAO.updateLogin(account);
		Log logVO = new Log();
		logVO.setUserid(account.getUserid());
		logVO.setName(account.getName());
		logVO.setLogin_ip(account.getLogin_ip());
		logVO.setLogin_type(account.getLogin_type());
	    logDAO.insertLogIn(logVO);
	}
	
	
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Override
	public void loginFailCnt(Account account) throws Exception {
	    accountDAO.updateFailLogin(account);
	}
	
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	public int selectMemberCount(Account account) throws Exception{
		return accountDAO.selectMemberCount(account);
	}
	
    
	/** 
	 * @param account
	 * @return List<Account>
	 * @throws Exception
	 */
	public List<Account> selectMemberList(Account account) throws Exception {
    	return accountDAO.selectMemberList(account);
    }
	
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void insertMember(Account account) throws Exception {
	    accountDAO.insertMember(account);
	    accountDAO.insertMemberAuth(account);

	}
	
	
	/** 
	 * @param account
	 * @return Account
	 * @throws Exception
	 */
	public Account selectMemberDetail(Account account) throws Exception {
	    return (Account) accountDAO.selectMemberDetail(account);
	}
	
	/** 
	 * @param account
	 * @return Account
	 * @throws Exception
	 */
	public Account selectMemberTokenDetail(Account account) throws Exception {
	    return (Account) accountDAO.selectMemberTokenDetail(account);
	}

	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public void updateMember(Account account) throws Exception{
	    accountDAO.updateMember(account);
	    
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateAccountNonExpired(Account account) throws Exception{
	    return accountDAO.updateAccountNonExpired(account);
	}

	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public int updateMemberPwd(Account account) throws Exception{
	    return (int)accountDAO.updateMemberPwd(account);
	}

	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void updateToken(Account account) throws Exception{
	    accountDAO.updateToken(account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateCredential(Account account) throws Exception{
	    return accountDAO.updateCredential(account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateLoginAuth(Account account) throws Exception{
	    return accountDAO.updateLoginAuth(account);
	}
	
	/** 
	 * @param account
	 * @return int
	 * @throws Exception
	 */
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int updateLoginImsi(Account account) throws Exception{
	    return accountDAO.updateLoginImsi(account);
	}
	
	/** 
	 * @param account
	 * @throws Exception
	 */
	@Override
	public void deleteMember(Account account) throws Exception {
		Account detail = accountDAO.selectMemberDetail(account);
	    accountDAO.deleteMemberAuth(detail);
	    accountDAO.deleteMember(detail);
	}

	/**
	 * 아이피 접근 권한
	 */

	@Override
	public int selectIPSearch(AccountIp accountIp) throws Exception {
	    return accountDAO.selectIPSearch(accountIp);
	}
	
	/** 
	 * @param accountIp
	 * @throws Exception
	 */
	@Override
	public void insertIP(AccountIp accountIp) throws Exception {
	    accountDAO.insertIP(accountIp);
	}
    
	/** 
	 * @param accountIp
	 * @return List<AccountIp>
	 * @throws Exception
	 */
	public List<AccountIp> selectIP(AccountIp accountIp) throws Exception {
        return accountDAO.selectIP(accountIp);
    }
    
	
	/** 
	 * @param accountIp
	 * @throws Exception
	 */
	@Override
	public void updateIP(AccountIp accountIp) throws Exception{
	    accountDAO.updateIP(accountIp);
	}
	
	
	/** 
	 * @param accountIp
	 * @throws Exception
	 */
	@Override
	public void deleteIP(AccountIp accountIp) throws Exception {
	    accountDAO.deleteIP(accountIp);
	}
	
}	
