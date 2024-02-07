<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="../../include/head.jsp"%>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
</head>

<body class="">
	<div class="wrapper " data-menu="/mgmt/customer/qna">
		<%@ include file="../../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../../include/top.jsp">
                <jsp:param name="searchHtml" value="customer" />
                <jsp:param name="sub" value="${fn:toLowerCase(inquiry_type)}" />
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
									<h4 class="card-title ">고객문의 상세</h4>
								</div>
								<div class="card-header">
									<h5 class="card-title ">문의자 정보</h5>
								</div>
								<div class="ln_solid"></div>
								<div class="card-body">
									<div class="row">
										<label class="col-sm-2 col-form-label">단지명</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static">${map.type=='RV02401'?map.complex_name:map.type_name}</div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">성함</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static">${!empty map.user_nm ?map.user_nm:'탈퇴회원' }</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">휴대전화</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static">${!empty map.tel ?map.tel:'-' }</div>
											</div>
										</div>
										<label class="col-sm-2 col-form-label">이메일</label>
										<div class="col-sm-4">
											<div class="form-group">
												<div class="form-control-static">${!empty map.email ?map.email:'--' }</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">답변상태</label>
										<div class="col-sm-10">
											<div class="form-group bmd-form-group">
												<div id="btnset">
													<div class="form-check form-check-inline">
														<label class="form-check-label"> <input class="form-check-input" type="radio" name="reply_status" value="RV02301" ${map.reply_status=='RV02301'?'checked="checked"':''}> 답변대기 <span class="circle"> <span class="check"></span>
														</span>
														</label>
													</div>
													<div class="form-check form-check-inline">
														<label class="form-check-label"> <input class="form-check-input" type="radio" name="reply_status" value="RV02303" ${map.reply_status=='RV02303'?'checked="checked"':''}> 답변완료(메일 발송 O) <span class="circle"> <span class="check"></span>
														</span>
														</label>
													</div>
													<div class="form-check form-check-inline">
														<label class="form-check-label"> <input class="form-check-input" type="radio" name="reply_status" value="RV02302" ${map.reply_status=='RV02302'?'checked="checked"':''}> 답변완료(메일 발송 X) <span class="circle"> <span class="check"></span>
														</span>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>

									<div class="card-header">
										<h5 class="card-title ">문의 내용</h5>
									</div>
									<div class="ln_solid"></div>
									<div class="row">
										<label class="col-sm-2 col-form-label">제목</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">${map.title}</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">문의내용</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">
													${map.inquiry_content}</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">등록일시</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">
												<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.crea_dtm }"/>
												${crea_dtm}
												</div>
											</div>
										</div>
									</div>
									<div class="card-header">
										<h5 class="card-title ">담당자 정보</h5>
									</div>
									<c:choose>
										<c:when test="${fn:length(list) > 0}">
											<c:forEach items="${list }" var="row">
												<div class="ln_solid"></div>
												<div class="row">
													<label class="col-sm-2 col-form-label">이름</label>
													<div class="col-sm-4">
														<div class="form-group">
															<div class="form-control-static">${row.name}</div>
														</div>
													</div>
													<label class="col-sm-2 col-form-label">이메일</label>
													<div class="col-sm-4">
														<div class="form-group">
															<div class="form-control-static">${row.email}</div>
														</div>
													</div>
												</div>
												<div class="row">
													<label class="col-sm-2 col-form-label">소속</label>
													<div class="col-sm-10">
														<div class="form-group">
															<div class="form-control-static">${row.department}</div>
														</div>
													</div>
												</div>
												<div class="ln_solid"></div>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="6">조회된 결과가 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<div class="card-header">
										<h5 class="card-title ">답변 내용</h5>
									</div>
									<div class="ln_solid"></div>
									<div class="row">
										<label class="col-sm-2 col-form-label">답변내용</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">
													<textarea class="form-control" name="reply_content" style="height:200px">${map.reply_content}</textarea>
												</div>
											</div>
										</div>
									</div>
									<c:if test="${map.reply_status=='RV02303'}">
									<div class="row">
										<label class="col-sm-2 col-form-label">답변일시</label>
										<div class="col-sm-10">
											<div class="form-group">
												<fmt:formatDate var="reply_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.reply_dtm }"/>
												<div class="form-control-static">${reply_dtm}</div>
											</div>
										</div>
									</div>
									<div class="row">
										<label class="col-sm-2 col-form-label">담당자</label>
										<div class="col-sm-10">
											<div class="form-group">
												<div class="form-control-static">${map.reply_name}</div>
											</div>
										</div>
									</div>
									</c:if>

								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-10"></div>
											<div class="col-2">
									        <a href="javascript:;" class="btn btn-primary" data-idx="${map.idx}" id="update">답변 ${map.reply_status=='RV02301'?'등록':'수정'}</a>
												<a href="javascript:;" class="btn btn-info" id="list">목록</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../../include/script.jsp"%>
	<form id="commonForm" name="commonForm" method="get"></form>
	<script>
		(function($) {
			$("#list").on("click", function(e) { //목록 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			var updateCount = 0;
			$('#update').click(function(){
				if(confirm('${map.reply_status=='RV02301'?'등록':'수정'}하시겠습니까?')){
					if(updateCount>0){
						alert('진행중입니다.');
						return;
					}
					if($('[name=reply_content]').val()==''){
						alert('답변내용을 입력해주세요.');
					}else{
						updateCount=1;
						var jsonData = {'idx':$(this).data('idx'),'reply_content':$('[name=reply_content]').val(),'reply_status':$('[name=reply_status]:checked').val()}
						$.ajax({
							type: 'POST',
							url: './status',
							data: jsonData,
							dataType: 'json',
							async: true,
							cache: false,
							success: function (data) {
								if(data.result=='ok'){
									alert('답변 등록이 완료 되었습니다.');
									window.location.reload();
								}
							},
							error: function (xhr, status, error) {
								alert('관리자에게 문의하시기 바랍니다.');
							}
						});
					}
				}
			});
			// $('[name=reply_status]').change(function(){
			// 	var preValue = "";
			// 	var reply_status = "";
			// 	if($(this).val()=='RV02303'){
			// 		reply_status = "답변완료";
			// 		preValue = 'RV02301';
			// 	}else{
			// 		reply_status = "답변대기";
			// 		preValue = 'RV02303';
			// 	}
			// 	if(confirm("답변상태를 "+reply_status+"로 변경하시겠습니까?")){

			// 		var params = {};
			// 		params['idx'] = '${map.idx}';
			// 		params['reply_status'] = $(this).val();
			// 		$.post('status',
			// 			params,
			// 			function(response){
			// 				if(response.result=="ok"){
			// 					alert("변경되었습니다.")
			// 				}else{
			// 					alert(response.result);
			// 				}
			// 			}
			// 		,'json');
			// 	}else{
			// 		$("[name='reply_status']:radio[value='" + preValue + "']").prop('checked', true);
			// 	}
			// });


			$.ajaxSetup({
				headers: {
					'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
				}
			});
		})(jQuery);

		function fn_openBoardList() {
			if(confirm('목록으로 이동하시겠습니까?')){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("/mgmt/customer/qna");
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
		}
	</script>
</body>

</html>