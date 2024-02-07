package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ComplexConstChild extends Complex  {
	/**
	 *
	 */
	private	String co_cd;
	private	String pjt_cd;
	private	String const_proc_dt;
	private	String regist_year;
	private	String regist_month;
	private	String const_rmks;
	private	String const_proc_rate;
	private	Date fst_reg_dtm;
	private	String regpsn_id;
	private	String regpsn_nm;
	private	Date fnl_upd_dtm;
	private	String updpsn_id;
	private	String updpsn_nm;
	private	String proctype;
	private String status;
	private int rnum = 0;
	private int fileCount = 0;
	
	private	Date const_fst_reg_dtm;
	private	String const_regpsn_id;
	private	Date const_fnl_upd_dtm;
	private	String const_updpsn_id;
	
	private List<ComplexFile> contFileList;
	private List<ComplexConstFile> contConstFileList;
	private int contConstFileCount;
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