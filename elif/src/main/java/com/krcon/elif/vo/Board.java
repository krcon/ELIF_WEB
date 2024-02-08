package com.krcon.elif.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Board{
	
	private int idx;
	private int pid;
	private int parent_idx;
	private String idx_sec;
	private String title;
	private String title_sub;
	private String contents;
	private String contents_mobile;
	private String tags;
	private String lang;
	private String[] langs;
	private String section;
	private String gubun;
	private String cateslug;
	private String slug;
	private String video;
	private String recom;
	private String status;
	private int hit_cnt;
	private String mainstatus;
	private int mainsort;
	private int sort;
	private String del_gb;
	private String crea_id;
	private String crea_name;
	private String pjt_cd;
	private String req_type;
	private String board_type;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date start_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date end_dtm;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date crea_dtm;
	private String upda_id;
	private String upda_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date upda_dtm;

	private String pdfkr;
	private String pdfen;
	private String pdfcn;
	
	private String typesArray;
	private String[] typesArrayList;
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
	
	private String prevNextDate;
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