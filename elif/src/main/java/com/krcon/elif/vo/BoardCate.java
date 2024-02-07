package com.krcon.elif.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardCate{
	private int idx;
	private int pid;
	private String catecode;
	private String description;
	private String code;
	private String types;
	private String slug;
	private String tag;
	private String html;
	private int count;
	private String images;
	private String main;
	private String tag_default;
	private Date crea_dtm;
	private Date upda_dtm;
	

	private String crea_id;
	private String crea_name;
	private String page;
	private String retype;
}