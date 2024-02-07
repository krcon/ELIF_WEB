package com.krcon.elif.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Customer extends Account{
	private int idx;
	private String pjt_cd;
	private String apartment;
	private String department;
	private String user_nm;
	private String email;
	private String tel;
	private String type;
	private String type_name;
	private String lang;
	private String[] langs;
	private String title;
	private String inquiry_content;
	private String user_id;
	private String reply_status;
	private String reply_status_name;
	private String reply_name;
	private String reply_id;
	private String reply_content;
	private String merge_dtm;
	private Date reply_dtm;
	private Date crea_dtm;
	private Date upda_dtm;
	private String del;
	private String complex_name;
	private String all;
	private String crea_id;
	private String crea_name;
	private String upda_id;
	private String upda_name;

	private String interest;	
	
	private String arrIdx;
	private String[] paramIdx;
	private String gubun_detect;
	private String typesArray;
	private String returnUrl;
	private String pagetype;
	private String types;
	private String images;
	private String sdate;
	private String edate;
	private String frontcol;
	private String mainpopup;
	private String orderby;
	private int file_count;
	
	private String reason;
	private String del_piriod;
	/*
	 * 검색관련 / 페이징
	 */

	private int count;
	private String colfiletype;
	private String page;
	private String retype;
	private String keyword;
	private String target;
	private int currentPageNo = 1;
	private int recordCountPerPage = 15;
	private int pageSize = 10;
	private int start = 0;
	private int end = 0;
	private int totalCount = 0;
}