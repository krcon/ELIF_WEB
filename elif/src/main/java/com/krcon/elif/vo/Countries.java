package com.krcon.elif.vo;

import lombok.Data;

@Data
public class Countries{
	private int id;
	private String kor_name;
	private String eng_name;
	private String chi_name;
	private String alpha2;
	private String alpha3;
	private int sort;
}