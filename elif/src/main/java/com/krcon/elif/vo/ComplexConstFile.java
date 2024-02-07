package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class ComplexConstFile implements Serializable  {
	/**
	 *
	 */
	private	int idx;
	private	String co_cd;
	private	String pjt_cd;
	private	String const_proc_dt;
	private	String original_file_name;
	private	String stored_file_name;
	private	int file_size;
	private	String file_gubun;
	private	int file_sort;
	private	String path_name;
	private String is_new;
	private	Date crea_dtm;

	
	/*
	 * 검색관련 / 페이징
	 */
	private String orderby;
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