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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/management_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="list" />
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
									<h4 class="card-title ">${code_type=='krice'?'KR산업 단지':'계룡건설 단지'}관리 수정</h4>
								</div>
								<div class="card-body">
									
									<form id="write" action="/mgmt/complex/${code_type}/management_modifyProc" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										
										<input type="hidden" name="currentPageNo" value="${param.currentPageNo }">
										<input type="hidden" name="target" value="${param.target }">
										<input type="hidden" name="keyword" value="${param.keyword }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="lang">단지코드 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<select name="pjt_cd" class="selectpicker" data-style="select-with-transition">
													<c:choose>
														<c:when test="${fn:length(project_list) > 0}">
															<c:forEach items="${project_list }" var="row">
															<option value="${row.pjt_cd}" ${map.pjt_cd==row.pjt_cd?'selected':''}>${row.pjt_mrkg_nm}</option>
															</c:forEach>
														</c:when>
													</c:choose>
													</select>
												</div>
											</div>
										</div>
										
										<div class="row">
											<label class="col-sm-2 col-form-label" for="name">단지명 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="pjt_nm" class="form-control" required value="${map.pjt_nm}" maxlength="100" title="단지명" data-title="단지명을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">유형 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<c:choose>
													<c:when test="${fn:length(complex_type) > 0}">
														<c:forEach items="${complex_type }" var="row" varStatus="status">
														<div class="form-check form-check-inline">
															<label class="form-check-label required">
																<input class="form-check-input" type="radio" name="housing" value="${row.code_id}" ${row.code_id==map.housing?'checked':empty(map.housing)?(status.count==1?'checked':''):''}> ${row.code_name}
																<span class="circle">
																	<span class="check"></span>
																</span>
															</label>
														</div>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="region">지역 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<select name="region" class="selectpicker required" data-style="select-with-transition">
														<c:choose>
															<c:when test="${fn:length(complex_region) > 0}">
																<c:forEach items="${complex_region }" var="row" varStatus="status">
																<option value="${row.code_id}" ${map.region==row.code_id?'selected':''}>${row.code_name}</option>
																</c:forEach>
															</c:when>
														</c:choose>
													</select>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="location">위치 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="sllt_info_loc" class="form-control" required value="${map.sllt_info_loc}" maxlength="100" title="위치" data-title="위치를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="households">세대수 <span></span></label>
											<div class="col-sm-10 col-lg-5">
												<div class="form-group bmd-form-group">
													<div class="input-group mb-3">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">총</span>
														</div>
														<input type="text" name="households" class="form-control numbercommaonly" onkeyup="numberWithCommas(this)" required value="${map.households}" maxlength="100" title="세대수" data-title="세대수를" placeholder="숫자만 입력">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">세대</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="tel">연락처</label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="sllt_info_addr_tel" class="form-control" value="${map.sllt_info_addr_tel}" maxlength="100" title="연락처" data-title="연락처를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="area">전용면적 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="area" class="form-control" required value="${map.area}" maxlength="100" title="전용면적" data-title="전용면적을">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">규모 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<input type="text" name="const_scope" class="form-control" required value="${map.const_scope}" maxlength="100" title="규모" data-title="규모를">
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">진행상태 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<c:choose>
													<c:when test="${fn:length(complex_progress) > 0}">
														<c:forEach items="${complex_progress }" var="row" varStatus="status">
														<div class="form-check form-check-inline">
															<label class="form-check-label">
																<input class="form-check-input" type="radio" name="progress" value="${row.code_id}" ${row.code_id==map.progress?'checked':''}> ${row.code_name}
																<span class="circle">
																	<span class="check"></span>
																</span>
															</label>
														</div>
														</c:forEach>
													</c:when>
												</c:choose>
											</div>
										</div>
										<div class="row" style="display:none;">
											<label class="col-sm-2 col-form-label"><b class="text-warning">미분양건 동시 노출</b>  <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="progress_const" value="Y" ${'Y'==map.progress_const?'checked':'' }> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="progress_const" value="N" ${'N'==map.progress_const?'checked':'' }> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">입주 예약 신청 유의사항 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<textarea name="reservation_comment" class="form-control" style="resize: none; height: 100px;">${map.reservation_comment}</textarea>
												</div>
												<div class="comment mt-0">* 해당 내용은 마이 엘리프 내 입주 예약 신청 페이지 하단에 노출되는 항목입니다.</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_scope">사전점검 방문예약 신청 유의사항 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<textarea name="visit_comment" class="form-control" style="resize: none; height: 100px;">${map.visit_comment}</textarea>
												</div>
												<div class="comment mt-0">* 해당 내용은 마이 엘리프 내 사전예약 방문 예약 신청 페이지 하단에 노출되는 항목입니다.</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="use_yn" value="Y" ${'Y'==map.use_yn?'checked':'' }> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="use_yn" value="N" ${'N'==map.use_yn?'checked':'' }> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="START_DTM">작성자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.regpsn_nm }" />
													</div>
												</div>
											</div>
											<label class="col-sm-2 col-form-label" for="START_DTM">등록일시 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<fmt:formatDate var="fst_reg_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.fst_reg_dtm }"/>
														<input type="text" class="form-control" disabled value="${fst_reg_dtm }" />
													</div>
												</div>
											</div>
										</div>
										<%-- <c:if test="${map.upda_name!=null }">
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
										</c:if> --%>
									</form>
								</div>
								<div class="card-footer">
									<div class="w-100 pb-3">
										<div class="row">
											<div class="col-2">

											</div>
											<div class="col-10">
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												<%-- <a href="javascript:;" class="btn btn-danger" id="delete">삭제</a> --%>
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
	function progress_const(){
		if($('[name=progress]:checked').val()=='RV02202'){
			$('[name=progress_const]').closest('.row').show();
		}else{
			$('[name=progress_const][value="N"]').prop('checked',true).closest('.row').hide();
		}
		
	}
	progress_const();
	$('[name=progress]').on('change',function(){
		progress_const();
	});
	
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
	$("a[name='file']").on("click", function (e) { //파일 이름
		e.preventDefault();
		fn_downloadFile($(this));
	});
	$(".delete-file").click(function () {
		var deleteFile = $(this);
		if (confirm("파일을 삭제하시겠습니까?")) {
			$.post("/mgmt/complex/${code_type}/fileDelete", { file_pjt_cd: $(this).data('seq') }).done(function (data) {
				if (data.result == 'ok') {
					if (deleteFile.parents('.add_img_area').find('.file_area').children('li').length < 1) {
						deleteFile.parents('.add_img_area').find('#btnAddFile2').click();
					}
					deleteFile.parents('.item-file').remove();
					alert('삭제 되었습니다.');

					//window.location.href="";
				} else {
					alert("파일이 없거나 삭제된 파일입니다.");
				}
			}).fail(function () {
				alert("관리자에게 문의하시기 바랍니다.");
			});
		}
	});

	function doSubmit(frm) {
		if(confirm('수정하시겠습니까?')){
			if (checkValidation(frm)) {
				var isOk = true;
				var arrFile = $(".upload-name");
				$.each(arrFile, function(index, item){
					if($(item).val().length > 0){
						var ext = $(item).val().split('.').pop().toLowerCase();
						if($.inArray(ext, ['jpg', 'png']) == -1) {
							alert($(item).val() + '는  허용된 파일형식이 아닙니다.');
							isOk = false;
							return false;
						}
					}
				});
				if(!isOk) return false;
				
				$('.numbercommaonly').val($('.numbercommaonly').val().replace(/,/gi, ""));
				var submitHtml = true;
				if (submitHtml) {
					var tags = "";
					var tags_index = 0;
					$('.rk-tags').each(function (index) {
						if ($(this).is(':checked')) {
							if (tags_index == 0) {
								tags += "" + $(this).val();
							} else {
								tags += "," + $(this).val();
							}
							tags_index++;
						}
					});
					$('form#' + frm).submit();
				}
			}
		}
	}

	function fn_openBoardList() {
		if(confirm('목록으로 이동하시겠습니까?')){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("/mgmt/complex/${code_type}/management_list");
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
		var pjt_cd = "${map.pjt_cd}";
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/deleteProc");
		if ("${!empty target}" == "true") {
			comSubmit.addParam("target", "${target}");
		}
		if ("${!empty keyword}" == "true") {
			comSubmit.addParam("keyword", "${keyword}");
		}
		if ("${!empty param.gubun}" == "true") {
			comSubmit.addParam("gubun", "${param.gubun}");
		}
		comSubmit.addParam("pjt_cd", pjt_cd);
		comSubmit.submit();

	}
	function fn_downloadFile(obj) {
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/common/downloadFile");
		comSubmit.addParam("pjt_cd", obj.data("pjt_cd"));
		comSubmit.addParam("BOARD_NAME", "BOARD");
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