package com.krcon.elif.vo;

import java.io.Serializable;

import lombok.Data;

@Data
public class AdminMenu implements Serializable  {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private int idx;
	private String ip;
	private String desciption;
	private int pid;
	private int sort;
	private String page;
	private String retype;
	private String userid;
	private String name;
	private String url;
	private String parent_idx;
	private String parent_name;
	private String full_sort;
	private String level;
}