package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class ComplexGuide implements Serializable  {
	/**
	 *
	 */
	private	int idx;
	private	String type;
	private	String type_name;
	private	String comments;
	private	String status;
	private	String crea_id;
	private	String crea_name;
	private	Date crea_dtm;
	private	String upda_id;
	private	String upda_name;
	private	Date upda_dtm;

	private int rownum;
	/*
	 * 검색관련 / 페이징
	 */
	private String sdate;
	private String edate;
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