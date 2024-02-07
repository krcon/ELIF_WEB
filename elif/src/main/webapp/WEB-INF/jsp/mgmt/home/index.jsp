<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
</head>
<body class="">
	<div class="wrapper ">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<%@ include file="../include/top.jsp"%>
			<!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">

					<c:choose>
						<c:when test="${fn:length(principal.adminMenu) > 0}">
							<c:forEach items="${principal.adminMenu }" var="row">

							<div class="col-xl-3">
								<div class="card card-product">
									<div class="card-header pb-0">
										<h4 class="card-title">${row.title}</h4>
									</div>
									<div class="card-body">
										<div class="table-responsive">
										<table class="table table-striped responsive-utilities jambo_table bulk_action">
											<tbody>
											<c:if test="${row.children.size()>0}">
												<c:forEach items="${row.children }" var="item">
												<tr>
													<td class="text-left"><a href="${item.url }">${item.title }</a></td>
												</tr>
												</c:forEach>
											</c:if>
											</tbody>
										</table>
										</div>
									</div>
								</div>
							</div>
							</c:forEach>
						</c:when>
					</c:choose>
					</div>
				</div>
			</div>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/script.jsp"%>
</body>

</html>