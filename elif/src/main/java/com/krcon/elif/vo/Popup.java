package com.krcon.elif.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Popup{
	private int idx;
	private int pid;
	private String lang;
	private String type;
	private String theme;
	private String gubun_web="";
	private String gubun_mobile="";
	private String title;
	private String desc_web="";
	private String desc_mobile="";
	private String url_web="";
	private String url_mobile="";
	private String url_web_target="";
	private String url_mobile_target="";
	private String pos_x="";
	private String pos_y="";
	private String size_w="";
	private String size_h="";
	private String status;
	private int sort;
	private String crea_id;
	private String crea_name;
	private String upda_id;
	private String upda_name;

	private String img_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date start_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date end_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date crea_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date upda_dtm;

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