package com.krcon.elif.vo;


import java.util.Date;

import lombok.Data;

@Data
public class Log{
	private int idx;
	private int pid;
	
	private String userid;
	private String username;
	private String name;
	private String updaid;
	private String updaname;
	private String login_ip;
	private String login_type;
	private String grant_type;
	private String prev;
	private String next;
	private String description;
	private String department;
	private String access_menu;
	private String reason;
	private Date crea_dtm;
	private Date down_dtm;
	private Date login_dtm;

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
}