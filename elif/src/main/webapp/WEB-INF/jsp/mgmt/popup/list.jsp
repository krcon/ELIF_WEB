<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <%@ include file="../include/head.jsp"%>
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/popup">
        <%@ include file="../include/sidebar.jsp"%>
        <div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="popup" />
			</jsp:include>
            <!-- End Navbar -->
            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header card-header-icon card-header-rose">
                                    <div class="card-icon">
                                        <i class="material-icons">assignment</i>
                                    </div>
                                    <h4 class="card-title ">팝업 리스트</h4>
                                </div>
                                <div class="card-body">
						            
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th width="5%" class="column-title text-center">번호</th>
													<th width="8%" class="column-title text-center">종류</th>
													<th width="10%" class="column-title text-center">구분</th>
													<th class="column-title text-center">제목 </th>
													<th width="6%" class="column-title text-center">THEME</th>
													<th width="6%" class="column-title text-center">작성자</th>
													<th width="6%" class="column-title text-center">노출여부</th>
													<th width="25%" class="column-title text-center">노출기간</th>
													<th width="10%" class="column-title text-center">등록일</th>
												</tr>
											</thead>
											<tbody>
											
								            <c:choose>
								                <c:when test="${fn:length(list) > 0}">
								                	<c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
								                    <c:forEach items="${list }" var="row">
													<tr>
														<td class="text-center">
															${num }
															<c:set var="num" value="${num-1}"/>
														</td>
														<td class="text-center">${row.type=='G'?'일반':'상단 고정' }</td>
														<td class="text-center">
														<c:set var="commaCnt" value="${0}"/>
														<c:if test="${row.gubun_web=='Y'}">
														${commaCnt>0?',':''}
														PC
														<c:set var="commaCnt" value="${commaCnt+1}"/>
														</c:if>
														<c:if test="${row.gubun_mobile=='Y'}">
														${commaCnt>0?',':''}
														Mobile
														<c:set var="commaCnt" value="${commaCnt+1}"/>
														</c:if>
														</td>
														<td>
															<a href="modify.do?idx=${row.idx }" data-modidx="${row.idx }">${row.title }</a>
															<c:if test="${row.file_count>0}">
															&nbsp;&nbsp;<span class="fa fa-floppy-o" data-toggle="tooltip" data-placement="bottom" title="" data-html="true"></span>
															</c:if>
														</td>
														<td class="text-center">${row.theme }</td>
														<td class="text-center">${ct:getMaskedName(row.crea_name)}</td>
														<td class="text-center">${row.status }</td>
														<td class="text-center">
                                                        <fmt:formatDate var="start_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.start_dtm }"/>
                                                        <fmt:formatDate var="end_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.end_dtm }"/>
														${fn:substring(start_dtm,0,16)} ~
														${fn:substring(end_dtm,0,16)}
														</td>
														<td class="text-center">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd" value="${row.crea_dtm }"/>
														${crea_dtm }
														</td>
													</tr>
								                    </c:forEach>
								                </c:when>
								                <c:otherwise>
								                    <tr>
								                        <td colspan="13">등록된 글이 없습니다.</td>
								                    </tr>
								                </c:otherwise>
								            </c:choose>
											</tbody>
										</table>
						            </div>
                                </div>
                                <div class="card-footer">
									<div class="w-100 pb-3">
                                        <div class="row">
                                            <div class="col-6">
                                                <a href="javascript:;" onclick="fn_openBoardWrite(this,'G')" class="btn btn-primary">일반 팝업 등록</a>
                                                <a href="javascript:;" onclick="fn_openBoardWrite(this,'T')" class="btn btn-primary">상단 고정팝업 등록</a>
                                            </div>
                                            <div class="col-6 text-right">
												<div class="pull-right">
													<ul class="pagination">
														<c:if test="${not empty paginationInfo}">
															<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
														</c:if>
													</ul>
													<input type="hidden" id="currentPageNo" name="currentPageNo" />
												</div>
											</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%@ include file="../include/footer.jsp"%>
        </div>
    </div>
    <%@ include file="../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
    <script>
	(function($){
	    $("a[data-idx]").on("click", function(e){ //제목 
	        e.preventDefault();
	        fn_openBoardDetail($(this));
	    });
		$("a[data-modidx]").on("click", function(e){ //제목 
	        e.preventDefault();
	        fn_openBoardUpdate($(this));
	    });
	    $("#btnSearch").click(function(){
	    	$("form[name=search]").submit();
	    });
	})(jQuery);

	function fn_openBoardWrite(obj,type){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/popup/write");
		comSubmit.addParam("type",type)
	    comSubmit.submit();
	}
	function fn_openBoardDetail(obj){
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/popup/view");
	    comSubmit.addParam("idx", obj.data("idx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
	    comSubmit.submit();
	}

	function fn_openBoardUpdate(obj) {
		var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/popup/modify");
	    comSubmit.addParam("idx", obj.data("modidx"));
	    comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if ("${!empty target}" == "true") {
			comSubmit.addParam("target", "${target}");
		}
		if ("${!empty keyword}" == "true") {
			comSubmit.addParam("keyword", "${keyword}");
		}
		if ("${!empty param.gubun}" == "true") {
			comSubmit.addParam("gubun", "${param.gubun}");
		}
		comSubmit.submit();
	}

	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
	    comSubmit.setUrl("/mgmt/popup/list");
	    comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		
		if("${!empty type}"=="true"){
			comSubmit.addParam("type", "${type}");
		}
		if("${!empty gubun}"=="true"){
			comSubmit.addParam("gubun", "${gubun}");
		}
		
	    comSubmit.submit();
	}
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>