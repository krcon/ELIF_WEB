package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class Project implements Serializable  {
	private	String co_cd; //
	private	String pjt_cd; //
	private	String pjt_mrkg_nm; //프로젝트 마케팅 명
	private	String bz_fg_cd; //사업장 구분 코드 : 자체/지주공동개발/지주공동주택/재개발/재건축/리모델링/도급/지역조합
	private	String sllt_knd_cd; //사업 구분 코드 : 아파트/주상복합/오피스텔/오피스/상가/아파트형공장/기타
	private	int blno; //동수
	private	int hhldno; //세대수
	private	int ugrn_stycnt; //지하 층수
	private	int ogrn_stycnt; //지상 층수
	private	String enfco_intg_cust_cd; //시행사 명
	private	String mng_dept_nm; //관리 부서 명
	private	String spnc_slplc_nm; //주관 영업소 명
	private	String pjt_omgr_pnm; //프로젝트 소장 성명
	private	String sllt_chrpsn_pnm; //분양 담당자 성명
	private	String lotr_plc_nm; //추첨 장소 명
	private	String sit_caddr; //현장 연락처
	private	String mofc_caddr; //관리사무소 연락처
	private	String mhs_caddr; //모델하우스 연락처
	private	String gofc_caddr; //구청 연락처
	private	String cont_cont_dt; //도급 계약 일자
	private	String bz_aprv_dt; //사업 승인 일자
	private	String sllt_cont_str_dt; //분양 계약 시작 일자
	private	String sllt_pann_dt; //분양 공고 일자
	private	String cnsv_rgs_dt; //보존 등기 일자
	private	String land_rgs_dt; //토지 등기 일자
	private	String lotr_dt; //추첨 일자
	private	String bf_chk_str_dt; //사전 점검 시작 일자
	private	String bf_chk_end_dt; //사전 점검 종료 일자
	private	String mibl_str_dt; //입주 시작 일자
	private	String mibl_end_dt; //입주 종료 일자
	private	long tot_sllt_amt; //총 분양 금액
	private	long cont_amt; //도급 금액
	private	int erth_sqms; //대지 면적
	private	int tad; //연면적
	private	int pjt_parklot_sqms; //프로젝트 주차장 면적
	private	int capart; //용적율
	private	int coll_bz_rt; //공동 사업 비율
	private	int max_engg_dgr; //최대 약정 차수
	private	String engg_amt_detr_unt_cd; //약정 금액 절사 단위 코드 : 1/10/100/1,000/.../100,000원
	private	String odufe_detr_unt_cd; //연체료 절사 단위 코드 : 1/10/100/1,000/.../100,000원
	private	String dcfe_detr_unt_cd; //할인료 절사 단위 코드 : 1/10/100/1,000/.../100,000원
	private	String mhs_zpcd; //모델하우스 우편번호
	private	String mhs_ftn_addr; //모델하우스 기본 주소
	private	String mhs_dtl_addr; //모델하우스 상세 주소
	private	String pjt_zpcd; //프로젝트 우편번호
	private	String pjt_ftn_addr; //프로젝트 기본 주소
	private	String pjt_dtl_addr; //프로젝트 상세 주소
	private	String ccnst_afth_zpcd; //준공 이후 우편번호
	private	String ccnst_afth_ftn_addr; //준공 이후 기본 주소
	private	String ccnst_afth_dtl_addr; //준공 이후 상세 주소
	private	String hld_hhld_agg_yn; //보류 세대 집계 여부
	private	String rntl_dispsl_agg_yn; //임대 매각 집계 여부
	private	String ccnst_stl_yn; //준공 정산 여부 : 미전산(n)/정산(y)
	private	String vrtl_bacct_auto_dstr_yn; //가상 계좌 자동 배분 여부
	private	String unccnst_bal_odufe_fg_cd; //미준공 잔금 연체료 구분 코드 : 미적용(n)/10%好?y)
	private	String mns_optn_bss_cd; //마이너스 옵션 기준코드 : 비율(a)/금액(b)
	private	String engg_amt_adup_bss_cd; //약정 금액 합산 기준 코드 : 다음차수(a)/잔금(b)
	private	String pjt_mmo; //프로젝트 메모
	private	String pjt_rmks; //프로젝트 비고
	private	String mhs_cmpd; //모델하우스 개요
	private	String mhs_annc_matt; //모델하우스 공지사항
	private	int sllt_pjt_atfl_id; //첨부파일 id : 공통 패키지의 첨부파일묶음번호를 참조하므로, id이나 number 타입으로 등록
	private	Date fst_reg_dtm; //최초 등록 일시
	private	String regpsn_id; //등록자 id
	private	Date fnl_upd_dtm; //최종 수정 일시
	private	String updpsn_id; //수정자 id
	private	int rntl_dmny_max_engg_dgr; //임대보증금 최대약정차수
	private	String cdoc_opt_yn; //계약서출력여부
	private	String stl_dt; //정산일자
	private	int sllt_img_atfl_id; //
	private	String engg_amt_hunodetr_unt_cd; //
	private	String mibl_dual_res_yn; //중복입주 가능여부(승강기/사다리차 동시간대 예약 가능여부)
	private	String mibl_sms_from_no; //입주예약sms발신자 번호
	private	String mibl_res_end_dt; //입주예약종료일시(null일경우 입주종료일이 기준임)
	private	String bfchk_sms_from_no; //사전점검sms발신자번호
						

	private	String code_type; //프로젝트 코드

	private int currentPageNo = 1;
	private int recordCountPerPage = 15;
	private int pageSize = 10;
	private int start = 0;
	private int end = 0;
	private int totalCount = 0;
	
}