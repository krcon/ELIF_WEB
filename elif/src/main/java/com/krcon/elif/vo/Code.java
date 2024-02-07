package com.krcon.elif.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class Code implements Serializable  {
	/**
	 *
	 */
	private String co_cd;
	private String code_group;
	private String code_id;
	private String code_name;
	private String code_eng_name;
	private String code_abbr_name;
	private String code_desc;
	private int code_seq;
	private String code_group_flag;
	private String use_flag;
	private String chrc_prpy1;
	private String chrc_prpy2;
	private String chrc_prpy3;
	private int no_prpy1;
	private int no_prpy2;
	private int no_prpy3;
	private Date fst_reg_dtm;
	private String regpsn_id;
	private Date fnl_upd_dtm;
	private String updpsn_id;
	private String[] code_array;
}