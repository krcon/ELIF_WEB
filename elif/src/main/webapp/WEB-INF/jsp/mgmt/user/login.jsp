<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="../include/head.jsp"%>
</head>

<body class="off-canvas-sidebar">
	<div class="wrapper wrapper-full-page">
		<div class="page-header login-page header-filter" data-color="blue" filter-color="black" style="background-image: url('/resources/manager/img/login2.jpg'); background-size: cover; background-position: top center;">
			<!--   you can change the color of the filter page using: data-color="blue | purple | green | orange | red | rose " -->
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-8 col-sm-8 ml-auto mr-auto">
						<form name="f" action="/mgmt/login" method="POST" class="">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="card card-login">
								<div class="card-header card-header-rose text-center">
									<h4 class="card-title">Login</h4>
								</div>
								<div class="card-body ">
									<span class="bmd-form-group">
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="material-icons">person</i>
												</span>
											</div>
											<input type="text" class="form-control" name="username" aria-describedby="emailHelp" required minLength="3" placeholder="아이디" value="${sessionScope['username']!=null?sessionScope['username']:''}">
											<c:remove var="username" scope="session" />
										</div>
									</span> 
									<span class="bmd-form-group">
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="material-icons">lock_outline</i>
												</span>
											</div>
											<input type="password" class="form-control" name="password" required minLength="3" placeholder="패스워드" value="">
										</div>
									</span>
								</div>
								<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
								<div class="card-body mt-1 px-3 text-center">
									<span class="text-danger">${fn:replace(sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message, newLineChar, "<br/>")}</span>
									<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
								</div>
								</c:if>
								<div class="card-footer justify-content-center">
									<button class="btn btn-info btn-lg w-75 mt-3">로그인</button>
								</div>
								<ul class="text-gray mt-2 mb-4 px-4">
									<li>1. 이 페이지는 관리자를 위한 페이지입니다.</li>
									<li>2. 각 권한에 따른 인증된 관리자만 접속이 가능합니다.</li>
									<li>3. 관리 작업을 마치신 후 반드시 로그아웃 하시기 바랍니다.</li>
									<li>4. 비밀번호 5회 이상 오류 시 등록하신 이메일로 임시 비밀번호가 발송됩니다.</li>
								</ul>
							</div>
						</form>
					</div>
				</div>
			</div>
			<%@ include file="../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../include/script.jsp"%>
	<script>
	
	<c:if test="${not empty sessionScope['SITE_ALERT']}">
	alert("${fn:replace(sessionScope['SITE_ALERT'], newLineChar, "<br/>")}");
	<c:remove var="SITE_ALERT" scope="session" />
	</c:if>
	</script>
</body>
</html>