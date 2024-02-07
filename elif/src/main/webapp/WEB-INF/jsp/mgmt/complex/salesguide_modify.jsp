<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<%@ include file="../include/head.jsp"%>
	<link href="/resources/manager/custom/summernote/summernote.css" rel="stylesheet">
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
									<h4 class="card-title ">분양 가이드 수정</h4>
								</div>
								<div class="card-body">
									
									<form id="write" action="/mgmt/salesguide_proc" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" id="idx" name="idx" value="${map.idx }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="lang">

											<c:choose>
												<c:when test="${map.type=='payment'}">
												분양금 납부
												</c:when>
												<c:when test="${map.type=='tax'}">
												취득세
												</c:when>
											</c:choose>
											 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<textarea name="comments" class="form-control" style="resize: none; height: 150px;">${map.comments}</textarea>
												</div>
											</div>
										</div>
										<c:if test="${map.crea_name!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="START_DTM">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.crea_name }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">등록일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="crea_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.crea_dtm }"/>
														<input type="text" class="form-control" disabled value="${crea_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<c:if test="${map.upda_name!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="upda_name">수정자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.upda_name }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">수정일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="upda_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.upda_dtm }"/>
														<input type="text" class="form-control" disabled value="${upda_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
									</form>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-2">

											</div>
											<div class="col-10">
												<c:choose>
												<c:when test="${map.crea_name!=null }">
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												</c:when>
												<c:otherwise>
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">등록</a> 
												</c:otherwise>
												</c:choose>
												<a href="javascript:;" id="list" class="btn btn-info">목록 </a>
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
	<script src="/resources/manager/custom/uploadfile.js"></script>
	<script src="/resources/manager/custom/summernote/summernote.js"></script>
	<script src="/resources/manager/custom/summernote/lang/summernote-ko-KR.js"></script>
	<form id="commonForm" name="commonForm" method="get"></form>
		<script>
		var main_count = 0;
		main_count = '${MAIN_COUNT }';
		if ($.isNumeric(main_count)) {
			main_count = parseInt(main_count);
		}


		$("#list").on("click", function (e) { //목록 버튼
			e.preventDefault();
			fn_openBoardList();
		});


		$("#delete").on("click", function (e) { //삭제 버튼
		
			if (confirm("삭제하시겠습니까?")) {
				e.preventDefault();
				fn_deleteBoard();
			}
		});
		$("a[name^='delete']").on("click", function (e) { //파일 삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});

		<c:if test="${not empty param.ALERT }">
			alert('${param.ALERT}')
		</c:if>

		function doSubmit(frm) {
			if(confirm('${map.idx>0?'수정':'추가'}하시겠습니까?')){
				if (checkValidation(frm)) {
					var isOk = true;
					var arrFile = $(".upload-name");
			
					$.each(arrFile, function(index, item){
						var extList = $(item).closest('.input-group').find('[type=file]').attr('accept').replace(/\./g,'').split(',');
						if($(item).val().length > 0){
							var ext = $(item).val().split('.').pop().toLowerCase();
							if($.inArray(ext, extList) == -1) {
								alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
								isOk = false;
								return false;
							}
						}
					});
					if(!isOk) return false;
					$('[name=sales_date]').val($('[name=sales_year]').val()+'-'+$('[name=sales_month]').val());
					var submitHtml = true;
					if (submitHtml) {
						
						$('form#' + frm).submit();
					}
				}
			}
		}

		function fn_openBoardList() {
			if(confirm('목록으로 이동하시겠습니까?')){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("/mgmt/salesguide_list");
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
		}
		function fn_deleteBoard() {
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/salesguide_deleteProc");
			if ("${!empty target}" == "true") {
				comSubmit.addParam("target", "${target}");
			}
			if ("${!empty keyword}" == "true") {
				comSubmit.addParam("keyword", "${keyword}");
			}
			if ("${!empty param.gubun}" == "true") {
				comSubmit.addParam("gubun", "${param.gubun}");
			}
			comSubmit.addParam("idx", idx);
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