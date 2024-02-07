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
	<div class="wrapper " data-menu="/mgmt/salesguide_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
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
									<h4 class="card-title ">분양 가이드 리스트</h4>
								</div>
								<div class="card-body">
									
									<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<thead>
												<tr class="headings">
													<th class="column-title text-center">분양 가이드 </th>
													<th width="20%" class="column-title text-center">등록/수정 일시</th>
													<th width="20%" class="column-title text-center">작성자</th>
													<th width="20%" class="column-title text-center"></th>
												</tr>
											</thead>
											<tbody>
											<c:choose>
												<c:when test="${fn:length(list) > 0}">
													<c:set var="num" value="${paginationInfo.getTotalRecordCount() - paginationInfo.getRecordCountPerPage() * (paginationInfo.getCurrentPageNo()-1) }"/>
													<c:forEach items="${list }" var="row">
													<tr>
														<td>
															<a href="#none" data-modidx="${row.idx }">${row.type_name }</a>
														</td>
														<td class="text-center">
															<c:choose>
																<c:when test="${!empty row.crea_name}">
																	<c:choose>
																		<c:when test="${!empty row.upda_name}">
																		<fmt:formatDate var="upda_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.upda_dtm }"/>
																		${upda_dtm }
																		</c:when>
																		<c:otherwise>
																		<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm" value="${row.crea_dtm }"/>
																		${crea_dtm }
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																-
																</c:otherwise>
															</c:choose>
														</td>
														<td class="text-center">
															<c:choose>
																<c:when test="${!empty row.crea_name}">
																	<c:choose>
																		<c:when test="${!empty row.upda_name}">
																		${ct:getMaskedName(row.upda_name)}
																		</c:when>
																		<c:otherwise>
																		${ct:getMaskedName(row.crea_name)}
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																-
																</c:otherwise>
															</c:choose>
														</td>
														<td class="text-center">
															<c:choose>
																<c:when test="${!empty row.crea_name}">
																<a href="#none" data-modidx="${row.idx }" class="btn btn-primary">수정</a>
																</c:when>
																<c:otherwise>
																<a href="#none" data-modidx="${row.idx }" class="btn btn-primary">등록</a>
																</c:otherwise>
															</c:choose>
														</td>
													</tr>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<tr>
														<td colspan="13" class="text-center">등록된 글이 없습니다.</td>
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
		$(document).on('click','.btn-flag-status',function(){
			if(confirm('수정하시겠습니까?')){
				var thisEle = $(this);
				var status =thisEle.text();
				if(status=='Y'){
					status = 'N';
				}else{
					status = 'Y';
				}
				var jsonData = {'idx':thisEle.data('idx'),'status':status}
				$.ajax({
					type: 'POST',
					url: 'salesguide_status',
					data: jsonData,
					dataType: 'json',
					async: true,
					cache: false,
					success: function (data) {
						console.log(data);
						if(data.result==true){
							thisEle.html(status);
							alert('변경되었습니다.');
						}
					},
					error: function (xhr, status, error) {
						alert('관리자에게 문의하시기 바랍니다.');
					}
				});
			}
		});
	})(jQuery);

	function fn_openBoardWrite(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/salesguide_write");
		comSubmit.submit();
	}
	function fn_openBoardDetail(obj){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/view");
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
		comSubmit.setUrl("/mgmt/salesguide_modify");
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
		comSubmit.setUrl("/mgmt/salesguide_list");
		comSubmit.addParam("currentPageNo", pageNo);
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
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
	</script>
</body>

</html>