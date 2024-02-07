package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Complex implements Serializable  {
	/**
	 *
	 */
	// 기존 RV100_PJT 사용


	private String co_cd; //회사코드
	private String pjt_cd; //분양프로젝트코드
	private String pjt_nm; //아파트 명
	private String sllt_info_loc; //분양아파트안내-분양안내-위치
	private String sllt_info_sch; //분양아파트안내-분양안내-분양일정
	private	String sales_year;
	private	String sales_month;
	private String sllt_info_mibl_ym; //분양아파트안내-분양안내-입주예정월
	private	String const_year;
	private	String const_month;

	private String sllt_info_addr_tel; //분양아파트안내-분양안내-분양문의전화
	private String const_scope; //건축규모
	private int const_g_area; //대지면적
	private String subhome_url; //분양홈페이지 주소

	private String sales_date; //분양일자
	private String area; //전용면적
	private String region; //지역
	private String region_name;
	private int households; //세대수
	private String housing; //주거종류
	private	String housing_name;
	private String sales_thumb_path; //분양 단지 썸네일경로
	private String sales_thumb_name; //분양 단지 썸네일명
	private String sales_thumb_origin; //분양 단지 썸네일명
	private String sales_thumb_old; //분양 단지 썸네일명
	private String sales_main_path; //분양 단지 메인썸네일경로
	private String sales_main_name; //분양 단지 메인썸네일명
	private String sales_main_origin; //분양 단지 메인썸네일명
	private String sales_main_old; //분양 단지 메인썸네일명
	private String sales_status; //분양 단지 사용 여부
	private String sales_view_status; //분양 단지 노출 여부
	private String const_thumb_path; //공사 단지 썸네일경로
	private String const_thumb_name; //공사 단지 썸네일명
	private String const_thumb_origin; //공사 단지 썸네일명
	private String const_thumb_old; //분양 단지 썸네일명
	private String const_status; //공사 단지 사용 여부
	private String const_view_status; //공사 단지 노출 여부
	private String mv_date; //입주 게시일
	private String mv_date_year; //입주 게시일
	private String mv_date_month; //입주 게시일
	private String mv_thumb_path; //입주 단지 썸네일경로
	private String mv_thumb_name; //입주 단지 썸네일명
	private String mv_thumb_origin; //입주 단지 썸네일명
	private String mv_thumb_old; //분양 단지 썸네일명
	private String mv_pre_start_date; //사전점검 방문기간 시작
	private String mv_pre_end_date; //사전점검 방문기간 끝
	private String mv_pre_file_path; //사전점검 안내문경로
	private String mv_pre_file_name; //사전점검 안내문명
	private String mv_pre_file_origin; //사전점검 안내문명
	private String mv_pre_file_old; //분양 단지 썸네일명
	private String mv_cert_date; //입주증 발급 게시일
	private String mv_file_doc_path; //입주 예약문경로
	private String mv_file_doc_name; //입주 예약문파일명
	private String mv_file_doc_origin; //입주 예약문파일명
	private String mv_file_doc_old; //분양 단지 썸네일명
	private String mv_start_date; //입주 예약 신청기간 시작
	private String mv_end_date; //입주 예약 신청기간 끝
	private String occupancy_status; //입주 단지 사용 여부
	private String occupancy_view_status; //입주 단지 노출 여부
	private String progress; //진행상태
	private	String progress_name;
	private String progress_const;
	private String progress_code;
	private	String reservation_comment; //입주 예약 신청 유의사항
	private	String visit_comment; //사전점검 방문예약 신청 유의사항
	private	String code_type;
	private	Date fst_reg_dtm;
	private	Date main_sort_dtm;
	private	String use_yn;
	private	String regpsn_id;
	private	String regpsn_nm;
	private	String updpsn_id;
	private	String updpsn_nm;
	private	String main_comment; //입주단지 등록일
	private	String sales_reg_id; //분양단지 작성자
	private	String sales_reg_nm; //분양단지 작성자
	private	Date sales_reg_dtm; //분양단지 등록일
	private	String const_reg_id; //공사단지 작성자
	private	String const_reg_nm; //분양단지 작성자
	private	Date const_reg_dtm; //공사단지 등록일
	private	String mv_reg_id; //입주단지 작성자
	private	String mv_reg_nm; //분양단지 작성자
	private	Date mv_reg_dtm; //입주단지 등록일
	private	String sales_upda_id; //분양단지 작성자
	private	String sales_upda_nm; //분양단지 작성자
	private	Date sales_upda_dtm; //분양단지 등록일
	private	String const_upda_id; //공사단지 작성자
	private	String const_upda_nm; //분양단지 작성자
	private	Date const_upda_dtm; //공사단지 등록일
	private	String mv_upda_id; //입주단지 작성자
	private	String mv_upda_nm; //분양단지 작성자
	private	Date mv_upda_dtm; //입주단지 등록일
	private	String view_div; //A:전체 R:리슈빌 E:엘리프

	private String const_regpsn_id;
	private String const_regpsn_nm;
	private boolean diff_date=false;
	private boolean reservationDiff_date=false;
	private	String[] region_array;
	private	String[] housing_array;
	private	String[] progress_array;

	private int const_count;
	private List<ComplexFile> occupancyFileList;
	
	private boolean frontbool=false;
	private String row_number="tc.fst_reg_dtm DESC";
	private String from_join="RIGHT OUTER";

	private String calendar_view_status;

	/*
	 * 검색관련 / 페이징
	 */
	private String sdate;
	private String edate;
	private String frontcol;
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