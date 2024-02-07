package com.krcon.elif.vo;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import lombok.Getter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "username")
public class Account implements UserDetails{
	private static final long serialVersionUID = 1L;
	private String username;
	  
	private int idx;
	private String userid;
	private String name;
	private String email;
	private String department;
	private String password;
	private String old_password;
	private String password_comfirm;
	private String enumber;
	private int loginCnt;
	private int loginFailCnt;
	private String grants;
	private String menus;
	private String mailNumber;
	private String login_ip;
	private String token;
	private String status;
	private Date token_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date start_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date end_dtm;
	private String crea_id;
	private String crea_name;
	private Date crea_dtm;
	private String upda_id;
	private String upda_name;
	private Date upda_dtm;
	private Date imsi_dtm;
	private Date login_dtm;
	private Date pass_dtm;
	private Date authsec_dtm;
	private String login_type;
	private String withdraw;
	private String authnum;
	private boolean isAccountNonExpired; 
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired; 
	private boolean isEnabled;
	private List<Map<String, Object>> adminMenu;
	private Collection <? extends GrantedAuthority> authorities;
	private String authority_name;
	private String profile;
	
	private String requested_menu;
	private List<AdminMenu> allMenu;
	
	/*
	 * 검색관련 / 페이징
	 */
	private String sdate;
	private String edate;
	private String page;
	private String lang;
	private String keyword;
	private String target;
	private int currentPageNo = 1;
	private int recordCountPerPage = 15;
	private int pageSize = 10;
	private int start = 0;
	private int end = 0;
	private int totalCount = 0;
	
	
	
	@Override
	public Collection <? extends GrantedAuthority>  getAuthorities() {
		return this.authorities;
	}
	@Override
	public String getPassword() {
		return this.password;
	}
	@Override
	public String getUsername() {
		return this.userid;
	} 
    public boolean isEnabled() {
        return isEnabled;
    }
	public void setEnabled(boolean isEnabled) {
        this.isEnabled = isEnabled;
    }
	
}