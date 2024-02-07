package com.krcon.elif.pagination;
 
public class FrontPaginationRenderer extends AbstractPaginationRenderer {
 
	public FrontPaginationRenderer() {
		firstPageLabel = "<a href=\"#none\" class=\"arr first\" onclick=\"{0}({1}); return false;\"><span class=\"blind\"><i class=\"fa fa-angle-double-left\" class=\"true\"></i></span></a>"; 
		previousPageLabel = "<a href=\"#none\" class=\"arr prev\" onclick=\"{0}({1}); return false;\"><span class=\"blind\"><i class=\"fa fa-angle-left\" class=\"true\"></i></span></a>";
		currentPageLabel = "<a href=\"#none\" class=\"current\">{0}</a>";
		otherPageLabel = "<a href=\"#none\" onclick=\"{0}({1}); return false;\">{2}</a>";
		nextPageLabel = "<a href=\"#none\" class=\"arr next\" onclick=\"{0}({1}); return false;\"><span class=\"blind\"><i class=\"fa fa-angle-right\" class=\"true\"></i></span></a>";
		lastPageLabel = "<a href=\"#none\" class=\"arr last\" onclick=\"{0}({1}); return false;\"><span class=\"blind\"><i class=\"fa fa-angle-double-right\" class=\"true\"></i></span></a>";
	}
}