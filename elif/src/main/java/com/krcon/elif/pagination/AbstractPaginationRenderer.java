package com.krcon.elif.pagination;

import java.text.MessageFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractPaginationRenderer implements PaginationRenderer {

	protected String firstPageLabel;
	protected String previousPageLabel;
	protected String currentPageLabel;
	protected String otherPageLabel;
	protected String nextPageLabel;
	protected String lastPageLabel;

	Logger log = LoggerFactory.getLogger(this.getClass());
	public String renderPagination(PaginationInfo paginationInfo, String jsFunction) {

		StringBuffer strBuff = new StringBuffer();

		int firstPageNo = paginationInfo.getFirstPageNo();
		int firstPageNoOnPageList = paginationInfo.getFirstPageNoOnPageList();
		// int totalPageCount = paginationInfo.getTotalPageCount();
		// int pageSize = paginationInfo.getPageSize();
		int lastPageNoOnPageList = paginationInfo.getLastPageNoOnPageList();
		int currentPageNo = paginationInfo.getCurrentPageNo();
		int lastPageNo = paginationInfo.getLastPageNo();

		if(currentPageNo==firstPageNo){
			strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, 0 }));
		}else{
			strBuff.append(MessageFormat.format(firstPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
		}

		if (currentPageNo > firstPageNo) {
			strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(currentPageNo - 1) }));
		} else {
			if(currentPageNo==firstPageNo){
				strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, 0 }));
			}else{
				strBuff.append(MessageFormat.format(previousPageLabel, new Object[] { jsFunction, Integer.toString(firstPageNo) }));
			}
			
		}
		

		for (int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
			if (i == currentPageNo) {
				strBuff.append(MessageFormat.format(currentPageLabel, new Object[] { Integer.toString(i) }));
			} else {
				strBuff.append(MessageFormat.format(otherPageLabel, new Object[] { jsFunction, Integer.toString(i), Integer.toString(i) }));
			}
		}

	
		if (currentPageNo < lastPageNo) {
			strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(currentPageNo + 1) }));
		} else {
			if(currentPageNo==lastPageNo){
				strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, 0 }));
			}else{
				strBuff.append(MessageFormat.format(nextPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
			}
			
		}
		if(currentPageNo==lastPageNo){
			strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, 0 }));
		}else{
			strBuff.append(MessageFormat.format(lastPageLabel, new Object[] { jsFunction, Integer.toString(lastPageNo) }));
		}
		return strBuff.toString();
	}
}