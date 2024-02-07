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
	<div class="wrapper " data-menu="/mgmt/complex/${code_type}/const_list">
		<%@ include file="../include/sidebar.jsp"%>
		<div class="main-panel">
			<jsp:include page="../include/top.jsp">
				<jsp:param name="searchHtml" value="complex" />
				<jsp:param name="sub" value="const_sub" />
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
									<h4 class="card-title ">
										${code_type=='krice'?'KR산업 공사단지':'계룡건설 공사단지'} 관리 상세정보 ${!empty map.pjt_cd?"수정":"등록"}
									</h4>
								</div>
								<div class="card-body">
									
									<form id="write" action="/mgmt/complex/${code_type}/const_sub_proc/${pjt_cd}" method="post" encType="multipart/form-data">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input type="hidden" id="pjt_cd" name="pjt_cd" value="${map.pjt_cd }"/>
										<%-- <input type="hidden" name="currentPageNo" value="${param.currentPageNo }">
										<input type="hidden" name="target" value="${param.target }">
										<input type="hidden" name="keyword" value="${param.keyword }"> --%>
										<c:choose>
											<c:when test="${empty map.const_proc_dt}">
											<input type="hidden" name="proctype" value="write">
											</c:when>
											<c:otherwise>
											<input type="hidden" name="proctype" value="modify">
											</c:otherwise>
										</c:choose>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_proc_dt"> 등록일자 <span></span></label>
											<div class="col-sm-10">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														
														<c:choose>
															<c:when test="${empty map.const_proc_dt}">
															<c:set var="now" value="<%=new java.util.Date()%>" />
															<fmt:formatDate var="nowDate" pattern="yyyy-MM-dd HH:mm" value="${now }"/>
															<input type="text" name="const_proc_dt" class="form-control datepicker" value="${nowDate }" />
															</c:when>
															<c:otherwise>
															<input type="text" name="const_proc_dt" class="form-control" readonly value="${map.const_proc_dt }" />
															</c:otherwise>
														</c:choose>
														
													</div>
												</div>

											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label" for="const_proc_rate">공정율 <span></span></label>
											<div class="col-sm-10 col-lg-5">
												<div class="form-group bmd-form-group">
													<div class="input-group mb-3">
														<input type="number" name="const_proc_rate" class="form-control numberic" required value="${map.const_proc_rate}" min="0" max="100" title="공정율" data-title="공정율을" placeholder="단위(%) 제외 숫자만 입력">
														<div class="input-group-prepend">
															<span class="input-group-text" id="basic-addon1">%</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">현장사진 <span></span></label>
											<div class="col-sm-10 col-lg-5">
												<div class="row fileupload-wrap">
													<div class="col-md-12 col-xs-12">
															<div class="card pt-4">
																<div class="card-body add_img_area">
																	<ul class="file_area" data-group="const_sub_file" data-type="file">
																		<c:set var="itemAccept" value=".gif,.jpg,.png" />
																		<c:choose>
																			<c:when test="${fn:length(const_sub_file)>0}">
																				<c:forEach var="row" items="${const_sub_file }" varStatus="var">
																					<li class="item-file">
																						<c:choose>
																							<c:when test="${item=='file' }">
																								<div class="upload-display">
																									<div class="upload-thumb-wrap">
																										<i class="fa fa-file-o"></i>
																									</div>
																								</div>
																							</c:when>
																							<c:otherwise>
																								<div class="upload-display">
																									<a href="${row.path_name }${row.stored_file_name }" class="upload-thumb-wrap imgpopup"><img src="${row.path_name }${row.stored_file_name }" class="upload-thumb"></a>
																								</div>
																							</c:otherwise>
																						</c:choose>
																						
																						<div class="input-group">
																							<input type="hidden" id="const_sub_filepjt_cd" name="const_sub_filepjt_cd_${var.index }" class="hidpjt_cd" value="${row.pjt_cd }">
																								<input type="file" name="const_sub_file_${var.index }" id="const_sub_file_${var.index }" class="upload-hidden" accept="${itemAccept }"> 
																								<input type="text" class="form-control upload-name" value="${row.original_file_name }" placeholder="업로드" readonly="readonly" required  title="현장사진" data-title="현장사진을"> 
																								<span class="input-group-btn"> 
																								<label for="const_sub_file_${var.index }" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																								<button type="button" data-seq="${row.idx }" class="btn btn-primary btn-fab delete-file"><i class="fa fa-close"></i></button>
																							</span>
																						</div>
																					</li>
																				</c:forEach>
																			</c:when>
																			<c:otherwise>
																				<li class="item-file">
																					<div class="input-group">
																						<input type="file" name="const_sub_file_0" id="const_sub_file_0" class="upload-hidden" accept="${itemAccept }"  >
																						<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly" required  title="현장사진" data-title="현장사진을"> 
																						<span class="input-group-btn"> 
																						<label for="const_sub_file" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>
																						
																						</span>
																					</div>
																				</li>
																			</c:otherwise>
																		</c:choose>
																	</ul>
																	<div class="form-group bmd-form-group">
																		<button type="button" id="btnAddFile2" class="btn btn-success btn-sm">파일 추가</button>
																	</div>
																</div>
															</div>
																<div class="comment mt-0">※ 이미지 권장 사이즈 : 가로 1200 * 세로 700px, 파일 형식: JPG,JPEG,PNG / 용량: 1MB 이하</div>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<label class="col-sm-2 col-form-label">노출여부 <span></span></label>
											<div class="col-sm-10 checkbox-radios">
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="status" value="Y" ${!empty map.status ? ('Y'==map.const_view_status?'checked':''):'checked' }> 사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
												<div class="form-check form-check-inline">
													<label class="form-check-label">
														<input class="form-check-input" type="radio" name="status" value="N" ${'N'==map.status?'checked':'' }> 미사용
														<span class="circle">
															<span class="check"></span>
														</span>
													</label>
												</div>
											</div>
										</div>
										<c:if test="${map.regpsn_nm!=null }">
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
														<fmt:formatDate var="fst_reg_dtm" pattern="yyyy-MM-dd HH:mm:ss" value="${map.const_fst_reg_dtm }"/>
														<input type="text" class="form-control" disabled value="${fst_reg_dtm }" />
													</div>
												</div>
											</div>
										</div>
										</c:if>
										<c:if test="${map.updpsn_nm!=null }">
										<div class="row">
											<label class="col-sm-2 col-form-label" for="updpsn_nm">수정자 <span></span></label>
											<div class="col-sm-4">
												<div class="form-group bmd-form-group">
													<div class="xdisplay_inputx form-group has-feedback">
														<input type="text" class="form-control" disabled value="${map.updpsn_nm }" />
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
												<c:when test="${empty map.const_proc_dt}">
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">등록</a> 
												</c:when>
												<c:otherwise>
												<a href="#write" onclick="javascript:doSubmit('write');" class="btn btn-primary">수정</a> 
												<a href="javascript:;" class="btn btn-danger" id="delete">삭제</a>
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
		if (checkValidation(frm)) {
			if(confirm('${empty map.const_proc_dt?'추가':'수정'}하시겠습니까?')){
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
				// $('[name=const_proc_dt]').val($('[name=regist_year]').val()+''+$('[name=regist_month]').val());
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
			comSubmit.setUrl("/mgmt/complex/${code_type}/const_sub_list/${pjt_cd}");
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
		var const_proc_dt = "${map.const_proc_dt}";
		var comSubmit = new ComSubmit();
		comSubmit.setUrl("/mgmt/complex/${code_type}/const_sub_deleteProc");
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
		comSubmit.addParam("const_proc_dt", const_proc_dt);
		comSubmit.submit();

	}
	$(".delete-file").click(function () {
		var deleteFile = $(this);
		if (confirm("파일을 삭제하시겠습니까?\n삭제후에는 복구할 수 없습니다.")) {
			$.post("/mgmt/complex/fileSubDelete", { idx: $(this).data('seq') }).done(function (data) {
				if (data.result == 'ok') {
					if($('#btnAddFile2').length>0){
						if (deleteFile.parents('.add_img_area').find('.file_area').children('li').length < 1) {
							deleteFile.parents('.add_img_area').find('#btnAddFile2').click();
						}
						deleteFile.parents('.item-file').remove();
					}else{
						deleteFile.parents('.item-file').find('.upload-name').val('');
						deleteFile.parents('.item-file').find('.upload-display').remove();
						deleteFile.parents('.item-file').find('.hidpjt_cd').remove();
						deleteFile.parents('.item-file').find('.delete-file').remove();
					}
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
	$.ajaxSetup({
		headers: {
			'X-CSRF-TOKEN': $('meta[name="_csrf"]').attr('content')
		}
	});
</script>
</body>

</html>