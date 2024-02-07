package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class Member implements Serializable{
	private static final long serialVersionUID = 1L;
	//회사코드
	private String co_cd = "50";
	//id
	private String user_id;
	//암호화 비번
	private String password;
	//성명
	private String user_nm;
	//생년월일
	private String yymmdd;
	//우편번호
	private String zipcd;
	//주소
	private String ftn_addr;
	//상세주소
	private String dtl_addr;
	//거주지구분코드
	private String area_fg_cd;
	//연락처_국번
	private String phone1="";
	//연락처_중간번
	private String phone2="";
	//연락처_끝번
	private String phone3="";
	//이메일
	private String email;
	//휴대폰_국번
	private String hp1;
	//휴대폰_중간번
	private String hp2;
	//휴대폰_끝번
	private String hp3;
	//휴대폰
	private String hp;
	//청약여부
	private String deptsit_yn;
	//청약년월
	private String deposit_yymm;
	//이메일 정보 수신여부
	private String email_send_yn;
	//SMS 정보 수신여부
	private String sms_send_yn;
	//전자동의서 사용 여부
	private String agree_yn;
	//주거구분
	private String live_fg_cd1;
	//주거종류
	private String live_fg_cd2;
	//결혼여부
	private String marry_fg_cd;
	//최종로그인일자
	private Date fnl_login_dtm;
	//최초가입일
	private Date fst_reg_dtm;
	//로그인 횟수
	private int login_cnt=0;
	//분양거래처코드
	private String sllt_cust_cd;
	//휴면계정처리일시
	private Date dormancy_dt;
	//S정상 H 휴면
	private String user_type;
	//휴면계정안내메일 발송일시
	private Date send_mail_dtm;
	
	//휴면계정처리예정일시
	private Date dormancy_yymmdd;

	//비밀번호 변경 일시
	private Date pwd_update_dtm;
	//비밀번호 변경 여부 - none:변경했음,change:변경해야함
	private String pwd_update_bool;
	

	//회원탈퇴 일자
	private Date secede_dtm;
	private int dormancy_date;
	private String returl;
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