<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head> <%@ include file="../../include/head.jsp"%>
	<meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
</head>

<body class="">
    <div class="wrapper " data-menu="/mgmt/customer/newsletter">
		<%@ include file="../../include/sidebar.jsp"%> 
		<div class="main-panel"> 
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="searchAction" value="/mgmt/customer/newsletter" />
                <jsp:param name="sub" value="newsletter" />
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
									<h4 class="card-title ">상세</h4>
								</div>
								<div class="card-header">
									<h5 class="card-title ">관심고객등록 정보</h5>
								</div>
								<div class="ln_solid"></div>
								<div class="card-body">
									<div class="row">
										<label class="col-sm-2 col-form-label">회사</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.company } </div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">부서</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.department } </div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">이름</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.name } </div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.email } </div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">관심 분야</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.interest } </div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">등록언어</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.lang } </div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">국가</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static"> ${map.nation } </div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">등록일시</label>
										<div class="col-sm-4">
											<div class="form-group">
												<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.crea_dtm }"/>
												<div class="form-control-static"> ${crea_dtm} </div>
											</div>
										</div>
									</div>

									<div class="ln_solid"></div>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-10"></div>
											<div class="col-2">
                                            	<a href="javascript:fn_delete('${map.idx}');" class="btn btn-danger">삭제</a>
												<a href="javascript:;" class="btn btn-info" id="list">목록</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> <%@ include file="../../include/footer.jsp"%>
		</div>
	</div> <%@ include file="../../include/script.jsp"%> <form id="commonForm" name="commonForm" method="get"></form>
	<script>
		(function ($) {
			$("#list").on("click", function (e) { //목록 버튼
				e.preventDefault();
				fn_newsletterList();
			});
		})(jQuery);
	
			function fn_delete(idx){
				if (confirm("삭제하시겠습니까?")) {
					var comSubmit = new ComSubmit();
					comSubmit.setUrl("/mgmt/customer/newsletter/delete");
					comSubmit.addParam("idx",idx);
				
					comSubmit.submit();
				}
			}
		
		function fn_newsletterList() {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/customer/newsletter");
			comSubmit.addParam("currentPageNo", "${currentPageNo}");
			if ("${!empty pid}" == "true") {
				comSubmit.addParam("pid", "${pid}");
			}
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



	</script>
</body>

</html>