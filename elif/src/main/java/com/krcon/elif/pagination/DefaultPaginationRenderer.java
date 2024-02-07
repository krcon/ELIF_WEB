package com.krcon.elif.pagination;
 
public class DefaultPaginationRenderer extends AbstractPaginationRenderer {
 
	public DefaultPaginationRenderer() {
		firstPageLabel = "<li class=\"page-item\"><a href=\"#none\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-double-left\" aria-hidden=\"true\"></i></span></a></li>"; 
		previousPageLabel = "<li class=\"page-item\"><a href=\"#none\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-left\" aria-hidden=\"true\"></i></span></a></li>";
		currentPageLabel = "<li class=\"active page-item\"><a href=\"#none\" class=\"page-link\">{0}</a>";
		otherPageLabel = "<li class=\"page-item\"><a href=\"#none\" class=\"page-link\" onclick=\"{0}({1}); return false;\">{2}</a></li>";
		nextPageLabel = "<li class=\"page-item\"><a href=\"#none\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-right\" aria-hidden=\"true\"></i></span></a></li>";
		lastPageLabel = "<li class=\"page-item\"><a href=\"#none\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-double-right\" aria-hidden=\"true\"></i></span></a></li>";
	}
}