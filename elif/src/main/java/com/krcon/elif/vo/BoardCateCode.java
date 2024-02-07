package com.krcon.elif.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardCateCode{
	private int pid;
	private String catecode;
	private String description;
	private Date crea_dtm;
	private Date upda_dtm;
	

	private String crea_id;
	private String crea_name;
	private String retype;
	private String page;
}