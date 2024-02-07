package com.krcon.elif.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardDownload{
	private int idx;
	private int board_idx;
	private String lang;
	private String title;

	private String company;
	private String email;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date crea_dtm;

	
	private String reason;
	private String del_piriod;


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
	private String img_name;
	private String file_name;
	private int file_count;


	private String start_dtm;
	private String end_dtm;
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