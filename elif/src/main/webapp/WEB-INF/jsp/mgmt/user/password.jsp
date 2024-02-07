<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="principal" property="principal" />
<!DOCTYPE html>
<html lang="ko">

<head> <%@ include file="../include/head.jsp"%> </head>

<body class="off-canvas-sidebar">
	<div class="wrapper wrapper-full-page">
		<div class="page-header register-page header-filter" data-color="blue" filter-color="black" style="background-image: url('/resources/manager/img/register.jpg'); background-size: cover; background-position: top center;">
			<!--   you can change the color of the filter page using: data-color="blue | purple | green | orange | red | rose " -->
			<div class="container">
				<div class="row">
					<div class="col-md-10 ml-auto mr-auto">
						<div class="card card-signup my-2">
							<h2 class="card-title text-center">비밀번호 변경</h2>
							<div class="card-body p-0">
								<div class="row">
									<div class="col-md-10 m-auto">
										<form name="f" action="/mgmt/user/password" method="POST" class="">
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<div class="row mt-3">
												<label class="col-sm-3 col-form-label">기존 비밀번호 <small>*</small></label>
												<div class="col-sm-8">
													<div class="form-group mt-0">
														<div class="input-group">
															<input type="password" class="form-control mt-0" name="old_password" required minlength="7" maxlength="20" title="기존 비밀번호" data-title="기존 비밀번호">
														</div>
													</div>
												</div>
											</div>
											<div class="row mt-3">
												<label class="col-sm-3 col-form-label">신규 비밀번호 <small>*</small></label>
												<div class="col-sm-8">
													<div class="form-group mt-0">
														<div class="input-group">
															<input type="password" class="form-control mt-0" name="password" required minlength="8" maxlength="20" title="신규 비밀번호" data-title="신규 비밀번호를">
														</div>
													</div>

													<ul class="text-gray text-small mt-2 mb-0">
														<li>- 최소 8자리 이상, 영어대문자/소문자/숫자/특수문자 중 3종류 조합</li>
														<li>- 기존 비밀번호와 동일 설정 불가</li>
														<li>- 아이디 포함 불가</li>
														<li>- 동일한 문자 또는 숫자 3자 이상 반복 사용 불가</li>
														<li>- 주기성 문자(abcd, 1234 등) 및 키보드상의 연속된 배열(asdf, qwert 등) 구성 불가</li>
													</ul>
												</div>
											</div>
											<div class="row mt-3">
												<label class="col-sm-3 col-form-label">신규 비밀번호 확인 <small>*</small></label>
												<div class="col-sm-8">
													<div class="form-group mt-0">
														<div class="input-group">
															<input type="password" class="form-control mt-0" name="password_comfirm" required minlength="8" maxlength="20" title="신규 비밀번호 확인" data-title="신규 비밀번호 확인을">
														</div>
													</div>
												</div>
											</div>
											<c:if test="${not empty SITE_ERROR}">
												<div class="row mt-3">
													<label class="col-sm-3 col-form-label"></label>
													<div class="col-sm-8">
														<span class="text-danger">${sessionScope["SITE_ERROR"]}</span>
														<c:remove var="SITE_ERROR" scope="session" />
													</div>
												</div>
											</c:if>
											<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
												<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
											</c:if>
											<div class="row">
												<div class="col-sm-12 text-center">
													<a href="javascript:void(0);" id="prev" class="btn btn-default btn-round mt-4 btn-min"> 이전 </a>&nbsp;&nbsp;
													<button type="submit" class="btn btn-primary btn-round mt-4 btn-min">수정</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div> <%@ include file="../include/footer.jsp"%>
		</div>
	</div> <%@ include file="../include/script.jsp"%>
    <script>
    $(function() {
		$('#prev').click(function(){
			history.back(-1);
		});
		$('[name=f]').submit(function(){
			var validate = checkPwd($('[name=password]').val(),$('[name=password_comfirm]').val(),$('[name=old_password]').val(), '${principal.username}');
			return validate;
		});
    });
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
    </script>
</body>

</html>
