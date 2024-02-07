package com.krcon.elif.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PopupFile{
	private int idx;
	private int board_idx;
	private String original_file_name;
	private String stored_file_name;
	private long file_size;
	private String file_gubun;
	private int file_sort;
	private int download;
	private String path_name;
	private String del_gb;
	private String comments;
	private Date crea_dtm;
	private String is_new;
}