<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="ct" uri="/WEB-INF/tlds/common.tld"%>
<sec:authentication var="principal" property="principal" />
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
									<h4 class="card-title">2단계 인증</h4>
								</div>
								<div class="card-body ">
									<span class="bmd-form-group">
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="material-icons">email</i>
												</span>
											</div>
											<input type="text" class="form-control" name="username" aria-describedby="emailHelp" placeholder="" value="${ct:getMaskedEmail(principal.email)}">
											<div class="input-group-end">
												<button type="button" id="authmail" class="btn btn-success btn-sm btn-min">인증</button>
											</div>
										</div>
										<div class="input-text-wrap">
											<ul class="text-gray text-small mt-2 mb-0">
												<li>- 이메일로 인증 번호가 발급됩니다.</li>
												<li>- 2단계 인증은 1일 1회입니다.</li>
											</ul>
										</div>
									</span> 
									<span class="bmd-form-group bmd-form-shown">
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"> <i class="material-icons">lock_outline</i>
												</span>
											</div>
											<input type="text" class="form-control" name="authnum" placeholder="인증 번호" value="">
										</div>
									</span>
								</div>
								<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
								<div class="card-body mt-1 px-3 text-center">
									<span class="text-danger">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</span>
									<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
								</div>
								</c:if>
								<div class="card-footer justify-content-center">
									<a href="/mgmt/logout" class="btn btn-light btn-sm"> 이전 </a>&nbsp;&nbsp;
									<button type="button" id="submitNum" class="btn btn-primary btn-sm">로그인</button>
								</div>
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
	$('#authmail').click(function(){
		$(this).html('재발송');
		//$(this).prop("disabled",true);
		var jsonData = {}
		$.ajax({
			type: 'POST',
			url:'/mgmt/anon/authemail',
			data: jsonData,
			dataType: 'json',
			async: true,
			cache :false,
			success: function(data){
				if(data.result==true){
					alert("인증번호를 보내드렸습니다.");
					$('.bmd-form-shown').show();
				}else{
					$(this).prop("disabled",false);
					alert("메일서버 오류 입니다. 관리자에게 문의 하세요.");
				}
			},
			error:function(xhr,status,error){
				alert( "관리자에게 문의하시기 바랍니다." );
			}
		});
	});
	$('#submitNum').click(function(){
		if($('[name=authnum]').val().length<3){
			alert('인증번호를 입력해주세요.');
		}else{
			var jsonData = {
				'authnum': $('[name=authnum]').val()
			}
			$.ajax({
				type: 'POST',
				url:'/mgmt/anon/authemailProc',
				data: jsonData,
				dataType: 'json',
				async: true,
				cache :false,
				success: function(data){
					if(data.result=='Y'){
						alert("인증이 완료되었습니다.");
						window.location.href="/mgmt/home"
					}else{
						alert("인증번호가 맞지 않습니다.");
					}
				},
				error:function(xhr,status,error){
					alert( "관리자에게 문의하시기 바랍니다." );
				}
			});
		}
	});
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
        }
    });
	</script>
</body>
</html>