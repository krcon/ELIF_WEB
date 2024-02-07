<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<jsp:scriptlet>
pageContext.setAttribute("crlf", "\r\n");
pageContext.setAttribute("lf", "\n");
pageContext.setAttribute("cr", "\r");
</jsp:scriptlet>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="../include/head.jsp"%>
</head>

<body class="">
	<div class="wrapper " data-menu="/mgmt/log">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="log" />
				<jsp:param name="sub" value="menu" />
			</jsp:include>
			<!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-icon card-header-rose">
									<div class="card-icon">
										<i class="material-icons">supervisor_account</i>
									</div>
									<h4 class="card-title ">메뉴 이용 기록</h4>
								</div>
								<div class="card-body">
									<ul class="nav nav-pills nav-pills-warning mt-3 mb-3" role="tablist">
										<li class="nav-item">
											<a href="/mgmt/log" class="nav-link">
											접속 기록
											</a>
										</li>
										<li class="nav-item">
											<a href="/mgmt/log/menu" class="nav-link active show">
											메뉴 이용 기록
											</a>
										</li>
										<%-- <li class="nav-item">
											<a href="/mgmt/log/excel" class="nav-link">
											엑셀 다운로드 기록
											</a>
										</li> --%>
									</ul>
									<div class="table-responsive">
									<table class="table table-striped responsive-utilities jambo_table bulk_action">
										<thead>
											<tr class="headings">
												<th width="5%" class="column-title text-center">NO</th>
												<th width="8%" class="column-title text-center">아이디 </th>
												<th width="8%" class="column-title text-center">이름 </th>
												<th width="15%" class="column-title text-center">접근 메뉴</th>
												<th width="" class="column-title text-center">상세내용</th>
												<th width="10%" class="column-title text-center">IP </th>
												<th width="15%" class="column-title text-center">접속일시 </th>
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
														<td class="text-center">
															${row.userid }
														</td>
														<td class="text-center">
															${ct:getMaskedName(row.username)}
														</td>
														<td class="text-center">
															${row.access_menu }
														</td>
														<td class="text-center">
															<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#queryModal" data-content="${fn:replace(row.description,lf,'<br>')}">
															<c:choose>
																<c:when test="${fn:length(row.description) gt 49}">
																<c:out value="${fn:substring(row.description, 0, 50)}"/>...
																</c:when>
																<c:otherwise>
																<c:out value="${row.description}"/>
																</c:otherwise>
															</c:choose>
															</button>
															
														</td>
														<td class="text-center">
															${row.login_ip }
														</td>
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${row.crea_dtm }"/>
														<td class="text-center last">${crea_dtm}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="6">조회된 결과가 없습니다.</td>
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


	<div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="queryModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-body">
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
	$(function() {
		$('#queryModal').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget) // Button that triggered the modal
			$(this).find('.modal-body').html(button.data('content'));
		})

		$('tr[data-href]').on("dblclick", function() {
			document.location = $(this).data('href');
		}).css({
			'cursor': 'pointer'
		});


	});
	function fn_openBoardUpdate(idx){
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/user/"+idx+"/modify");
		comSubmit.addParam("currentPageNo", "${currentPageNo}");
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		comSubmit.submit();
	}
	function fn_search(pageNo){
        if(pageNo==0){
            return false;
        }
	    var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/log/menu");
		comSubmit.addParam("currentPageNo", pageNo);
		if("${!empty target}"=="true"){
			comSubmit.addParam("target", "${target}");
		}
		if("${!empty keyword}"=="true"){
			comSubmit.addParam("keyword", "${keyword}");
		}
		
		
		if("${!empty sdate}"=="true"){
			comSubmit.addParam("sdate", "${sdate}");
		}
		if("${!empty edate}"=="true"){
			comSubmit.addParam("edate", "${edate}");
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